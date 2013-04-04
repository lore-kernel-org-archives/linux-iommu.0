From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] irq: add quirk for broken interrupt remapping on 55XX chipsets
Date: Thu, 4 Apr 2013 08:57:06 -0600
Message-ID: <CAErSpo6x5rokg8np7xEKO6y6Qke5X7=r7J7VB2LVrAGGzDC1sA@mail.gmail.com>
References: <1362158276-4901-1-git-send-email-nhorman@tuxdriver.com>
 <1362423859-18516-1-git-send-email-nhorman@tuxdriver.com> <CAErSpo4=L9q+q5hqP2Avw6uceQwZiPuOzadhsqGpu6aP53PMbQ@mail.gmail.com>
 <1365085649.28127.66.camel@i7.infradead.org> <20130404145012.GA3403@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130404145012.GA3403@neilslaptop.think-freely.org>
Sender: linux-pci-owner@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Prarit Bhargava <prarit@redhat.com>, Don Zickus <dzickus@redhat.com>, Jiang Liu <jiang.liu@huawei.com>, Asit Mallick <asit.k.mallick@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 4, 2013 at 8:50 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
> On Thu, Apr 04, 2013 at 03:27:29PM +0100, David Woodhouse wrote:
>> On Wed, 2013-04-03 at 17:53 -0600, Bjorn Helgaas wrote:
>> > );
>> > > +
>> > > +       if ((revision == 0x13) && irq_remapping_enabled) {
>> > > +                pr_warn(HW_ERR "This system BIOS has enabled interrupt remapping\n"
>> > > +                        "on a chipset that contains an errata making that\n"
>> > > +                        "feature unstable.  Please reboot with nointremap\n"
>> > > +                        "added to the kernel command line and contact\n"
>> > > +                        "your BIOS vendor for an update");
>>
>> This should be WARN_TAINT(TAINT_FIRMWARE_WORKAROUND). And 'an erratum'.
>>
> Ok, copy that. I'll repost shortly

When you do, please include URLs for any problem reports or bugzillas you have.

I assume Windows "just works" in this situation?
