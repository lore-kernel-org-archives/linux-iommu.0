From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to
 return bus number and device id
Date: Tue, 26 Mar 2013 16:23:32 -0600
Message-ID: <CAErSpo6QWxya9PBKngvfgjjZZ2bA=BtMHRBsCpj8rMMC5itiRQ@mail.gmail.com>
References: <1362009978.2808.33.camel@lorien2> <CAErSpo6DjjSKCFL6CjmqkOAyc1iU1TG1=n=K=AXPcU_r6ZdPGA@mail.gmail.com>
 <20130326215944.GB30540@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130326215944.GB30540@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: shuah.khan@hp.com, Jiang Liu <jiang.liu@huawei.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>, iommu@lists.linux-foundation.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkhan@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 26, 2013 at 3:59 PM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi Bjorn,
>
> On Tue, Mar 26, 2013 at 03:41:07PM -0600, Bjorn Helgaas wrote:
>> Since some of these touch drivers/iommu, it'd be good if you acked
>> them again, Joerg.  I know you acked them before, but there have been
>> minor changes since then, so I didn't add your ack to these.  But if
>> you're still OK with them, I'll refresh the branch to add it now.
>
> Looks still good to me. You can add my
>
> Acked-by: Joerg Roedel <joro@8bytes.org>
>
> if you want.

Added and branch updated, thanks!
