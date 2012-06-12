From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/7] IOMMU: Groups support
Date: Mon, 11 Jun 2012 19:55:24 -0700
Message-ID: <CAErSpo6oaGBL7uG4ys7cp=qNP6KK3xgi-_MkmvDULmfpk-+-wA@mail.gmail.com>
References: <20120530201424.31527.33142.stgit@bling.home> <20120606110514.GG757@amd.com>
 <1339429021.24037.8.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1339429021.24037.8.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, david@gibson.dropbear.id.au, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, ddutile@redhat.com, liuj97@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 11, 2012 at 8:37 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Wed, 2012-06-06 at 13:05 +0200, Joerg Roedel wrote:
>> On Wed, May 30, 2012 at 02:18:29PM -0600, Alex Williamson wrote:
>> > v2:
>> > =A0- Trickle down changes from pci_get_dma_source() to better hand=
le
>> > =A0 =A0PCI device reference counting in IOMMU driver patches
>>
>> Okay, I looked again over the code and looks good for merging to me.
>
> Great, thanks Joerg!
>
>> =A0The
>> IOMMU Groups code depends on changes in the PCI code. We need to wor=
k
>> out how to merge this.
>>
>> Bjorn,
>>
>> I need the PCI changes before I can merge the IOMMU Groups code. The=
re
>> are two ways that would work for me:
>>
>> =A0 =A0 =A0 a) You Ack the PCI patch-set from Alex and I put it into=
 my tree
>> =A0 =A0 =A0 =A0 =A0and merge the IOMMU Group code on-top, or
>> =A0 =A0 =A0 b) You merge the PCI related patch-set into a seperate b=
ranch
>> =A0 =A0 =A0 =A0 =A0which you can merge into your next-branch and whi=
ch I can
>> =A0 =A0 =A0 =A0 =A0pull in to merge IOMMU Groups on-top.
>>
>> Please let me know what works best for you.

Joerg, I put the PCI changes into my "next" branch
(http://git.kernel.org/?p=3Dlinux/kernel/git/helgaas/pci.git;a=3Dshortl=
og;h=3Drefs/heads/next).
 My feeble excuse is that I was on vacation last week, but that's
pretty lame because this has been hanging for much longer than that.

Bjorn
