From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
Date: Tue, 03 Jul 2018 09:38:27 -0700
Message-ID: <4b05b03ac6c3537d06754562efd477ba75413b62.camel@perches.com>
References: <20180703064005.18908-1-colin.king@canonical.com>
         <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
         <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
         <d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
         <f3e15437-68c1-58eb-bc34-93fa70e50dc9@amd.com>
         <6fbcf273-bc0a-5dbd-fa0e-a7f656c4ccbc@canonical.com>
         <dc5d5fc0-0c4b-3728-2dba-987840e7c1fc@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc5d5fc0-0c4b-3728-2dba-987840e7c1fc@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hook, Gary" <ghook@amd.com>, Colin Ian King <colin.king@canonical.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-07-03 at 11:27 -0500, Hook, Gary wrote:
> On 7/3/2018 11:24 AM, Colin Ian King wrote:
> > On 03/07/18 17:21, Hook, Gary wrote:
> > > On 7/3/2018 10:55 AM, Joe Perches wrote:
> > > > On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
> > > > > On 07/03/2018 05:07 AM, Joe Perches wrote:
> > > > > > On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
> > > > > > > Currently tag is being assigned but not used, it is missing from
> > > > > > > the dev_err message, so add it in.
> > > > > > > 
> > > > > > > Cleans up clang warning:
> > > > > > > warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> > > > > > 
> > > > > > []
> > > > > > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > > > > > 
> > > > > > []
> > > > > > > @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu
> > > > > > > *iommu, void *__evt)
> > > > > > >             pasid = ((event[0] >> 16) & 0xFFFF)
> > > > > > >                 | ((event[1] << 6) & 0xF0000);
> > > > > > >             tag = event[1] & 0x03FF;
> > > > > > > -        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
> > > > > > > pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
> > > > > > > +        dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x
> > > > > > > pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
> > > > > > >                 PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> > > > > > > -            pasid, address, flags);
> > > > > > > +            pasid, address, flags, tag);
> > > > > > 
> > > > > > Seems to have a superfluous ] that should be removed.
> > > > > 
> > > > > Yeah, I pretty much messed up all of the log messages in that function.
> > > > > My apologies. I'll create a patch for that problem; it shouldn't be
> > > > > fixed here.
> > > 
> > > Well, no, I misremembered. The extraneous square brace has been there
> > > forever. Needs fixin', though.
> > > 
> > 
> > The opening square bracket is much earlier:
> > 
> > dev_err(dev, "AMD-Vi: Event logged [");
> > 
> > ..and all the subsequent dev_err messages have the trailing square bracket.
> 
> Gah! Mystery solved. I'd forgotten about that.
> 
> "Never mind."
> 

It stems from the misconversion from printk to dev_err

The initial dev_err is fine but all the dev_err uses
in the switch/case should use pr_cont, not dev_err

(there's a suggested patch below this commit reference)

---
>From 90ca3859f5ea90050d00e695355934b37357e7bb Mon Sep 17 00:00:00 2001
From: Gary R Hook <gary.hook@amd.com>
Date: Thu, 8 Mar 2018 18:34:41 -0600
Subject: [PATCH] iommu/amd: Use dev_err to send events to the system log

Remove printk and use a more preferable error logging function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 55 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 997a947ddc3b..4cd19f93ca15 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -547,6 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
+       struct device *dev = iommu->iommu.dev;
        int type, devid, domid, flags;
        volatile u32 *event = __evt;
        int count = 0;
@@ -573,53 +574,53 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
                amd_iommu_report_page_fault(devid, domid, address, flags);
                return;
        } else {
-               printk(KERN_ERR "AMD-Vi: Event logged [");
+               dev_err(dev, "AMD-Vi: Event logged [");
        }
 
        switch (type) {
        case EVENT_TYPE_ILL_DEV:
-               printk("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
-                      "address=0x%016llx flags=0x%04x]\n",
-                      PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-                      address, flags);
+               dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
+                       "address=0x%016llx flags=0x%04x]\n",
+                       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+                       address, flags);

etc...

so this could be:

---
 drivers/iommu/amd_iommu.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 596b95c50051..f78cfa094301 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -572,43 +572,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(devid, pasid, address, flags);
 		return;
-	} else {
-		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
+	dev_err(dev, "AMD-Vi: Event logged [");
+
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		pr_cont("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-			"address=0x%016llx flags=0x%04x]\n",
+		pr_cont("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		pr_cont("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		pr_cont("ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
+		pr_cont("COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
+		pr_cont("IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		pr_cont("INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
@@ -616,12 +615,12 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		pr_cont("INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	default:
-		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
+		pr_cont("UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
 	}
 
