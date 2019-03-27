From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
Date: Wed, 27 Mar 2019 14:14:20 +0530
Message-ID: <CABe79T6QVF-Dgajj6S_0Z9ZnfsV3vuWUasU-eLtTBPkEaBzjAw@mail.gmail.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com> <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

Could you please help to review the patch series below?

Thanks,
Srinath.

On Thu, Feb 21, 2019 at 2:29 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Hi Bjorn,
>
> Please help to review this patch series.
> Thank you.
>
> Regards,
> Srinath.
> On Fri, Jan 25, 2019 at 3:44 PM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > Few SOCs have limitation that their PCIe host can't allow few inbound
> > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > DT property and this address ranges are required to do IOVA mapping.
> > Remaining address ranges have to be reserved in IOVA mapping.
> >
> > PCIe Host driver of those SOCs has to list all address ranges which have
> > to reserve their IOVA address into PCIe host bridge resource entry list.
> > IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma-resv window list
> >   iommu/dma: Reserve IOVA for PCI host reserve address list
> >   PCI: iproc: Add dma reserve resources to host
> >
> >  drivers/iommu/dma-iommu.c           |  8 ++++++
> >  drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 62 insertions(+), 1 deletion(-)
> >
> > --
> > 2.7.4
> >
