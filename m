Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5490C004C9
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 10:34:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CED2087F
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 10:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I06S5IOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CED2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F051E3348;
	Tue,  7 May 2019 10:33:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 42748316D
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 10:33:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F6068DE
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 09:56:08 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id e11so8357401wrs.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 07 May 2019 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=IHeTau53rhyWfO0CEZaf8TCogPgsV/f85c5XRY2FpLM=;
	b=I06S5IOarXEB/Rf8KhJ8SfEAoJrkDpxZTo6cDWUP6nlceF4XGWjqb6oVabXf17/jUj
	LwuNPrwM+Whj3lIPAaHPJ3jeSY+nd7ayIM0Jii1WlRfCzjzPzgnqnLvMVdCiDu28lUcR
	1tEx7wuMaIeQEHTxZmxuTBi7ssyBnNcxWS1lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=IHeTau53rhyWfO0CEZaf8TCogPgsV/f85c5XRY2FpLM=;
	b=h9hXo3K1Qx+JRbmrCLPdQr5UORbI9hKfPRUl+RgkBSUEo7aH6T5oUbJOTJx5Zrw+jS
	obgUsRpbp//6rlFbONoeFlvz4SgRw4jC8eN1VRsWDyhqjodBQxb78uOOKh+H6f3k5TDZ
	AvbRmXDssQdEsUO/m7geAqBJG8OYxoVQiGR2NQuHMxQEeGGy96v3Bag3nvPv3oYE+pqU
	GUeV+3Q5777HZFaukAK4CgcJ0r6NtYX5XdvipQ6w8rhzvcp7LM9N9Kd7Hh86eu3TjgRk
	UJbDhkAVIwfRZ6IjKtDXRCTVCDOXscQtVNU9rUPS0MSZtQVtUlEJ7Rvpiwb/TBkOCNQB
	DNvw==
X-Gm-Message-State: APjAAAXiFq9QXNlOgslOMorj9iu4X+G+zvhcBlarr/3TQ9yNr4Y2+tSt
	J+zspRAAieQyTWfMaUOStUzSwtq4vPru5u9ZMv2k9Q==
X-Google-Smtp-Source: APXvYqwpyZql/DVaMZQlJQ4tp1wmaegr8/4zAmfIGvL/FFytGrVm3guHpUfKnCBrOcV6rhqM2oVmzL4885QLHRebxks=
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr21425833wrs.250.1557222966866; 
	Tue, 07 May 2019 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
	<1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
	<20190506211208.GA156478@google.com>
	<20190507094102.GA10964@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190507094102.GA10964@e121166-lin.cambridge.arm.com>
Date: Tue, 7 May 2019 15:25:55 +0530
Message-ID: <CABe79T5d-H8XYmDz0463oqS6pF5X8=zi+1YSRLVASuGdjHZgXQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource entries
	to host bridge
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Bjorn,

Thank you.

Regards,
Srinath.

On Tue, May 7, 2019 at 3:11 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, May 06, 2019 at 04:12:08PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 03, 2019 at 07:35:34PM +0530, Srinath Mannam wrote:
> > > The IPROC host controller allows only a subset of physical address space
> > > as target of inbound PCI memory transactions addresses.
> > >
> > > PCIe devices memory transactions targeting memory regions that
> > > are not allowed for inbound transactions in the host controller
> > > are rejected by the host controller and cannot reach the upstream
> > > buses.
> > >
> > > Firmware device tree description defines the DMA ranges that are
> > > addressable by devices DMA transactions; parse the device tree
> > > dma-ranges property and add its ranges to the PCI host bridge dma_ranges
> > > list; the iova_reserve_pci_windows() call in the driver will reserve the
> > > IOVA address ranges that are not addressable (ie memory holes in the
> > > dma-ranges set) so that they are not allocated to PCI devices for DMA
> > > transfers.
> > >
> > > All allowed address ranges are listed in dma-ranges DT parameter.
> > >
> > > Example:
> > >
> > > dma-ranges = < \
> > >   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> > >   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> > >   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> > >
> > > In the above example of dma-ranges, memory address from
> > >
> > > 0x0 - 0x80000000,
> > > 0x100000000 - 0x800000000,
> > > 0x1000000000 - 0x8000000000 and
> > > 0x10000000000 - 0xffffffffffffffff.
> > >
> > > are not allowed to be used as inbound addresses.
> > >
> > > Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > [lorenzo.pieralisi@arm.com: updated commit log]
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > ---
> > >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 43 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > > index c20fd6b..94ba5c0 100644
> > > --- a/drivers/pci/controller/pcie-iproc.c
> > > +++ b/drivers/pci/controller/pcie-iproc.c
> > > @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
> > >     return ret;
> > >  }
> > >
> > > +static int
> > > +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> > > +                    struct of_pci_range *range)
> >
> > Just FYI, I cherry-picked these commits from Lorenzo's branch to fix
> > the formatting of this prototype to match the rest of the file, e.g.:
>
> Thank you, I noticed too but I forgot to update it before merging
> v6 from the list.
>
> Thanks,
> Lorenzo
>
> > >  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> > > ...
> > >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
