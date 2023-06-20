Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8A171D5
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:58:34 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-66872d4a141so1404513b3a.1
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687273114; x=1689865114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRhsrk7uXeHgVGLFj/D6U74jUewZ/NwDci/F+F6tH7A=;
        b=JyoP6Jc0Zu9MvSMWYO8BEaXsYDGMX2Kjulm7Pu6qSwz9K67Y8WS66S8ZFTYmuz9JEK
         nGI2POAa7S25V+bIS0+WcgNruZtZQUmVxHrty8HduEmimL6/KjHXlKliA6exDt1iSjrm
         1nSBdRguP0mPvbw57IOo8Lvnunbftt9I0D3gPk0iH6kUySVuiMFijAutHcXkMHFeLt+M
         huSuTOt9pVBz/0xjVXjMOIwi3E3Cm6hpDiURgKVhMj6R5uW7a6HYCKrXM1InNoHEas7g
         lIS7Hi6POBnhQFHiZWWx9QMY4or4WSJrpKViuN/tfpAWhTrPlSRtQ4I2RtF9zL0nozUN
         ZFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273114; x=1689865114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRhsrk7uXeHgVGLFj/D6U74jUewZ/NwDci/F+F6tH7A=;
        b=MeaW2tVxwNbB6i0JkH+QsLeEk62ox0hWaQecpNc4mG+PPztGtaQlaNWd7ItDXwKijQ
         etzWpAttqGS1qLy5pnvtsduKAYuQb+WiWYpvyhTOfHwGzNKAomvunDMRs2CSGlddv7g1
         qL7Wg7D+cT0+d/ABuaQ2x4ry491OvUCWo1+dWVDRKlqPh18opknrV//GoTROmFG6CbSK
         GoDuFAdrU408j5aCVzUPHJfi1Nw0XcUX2p1/hOlSxV4qQCYXEHs0U4mT7Osv1oCq/pvq
         c0Aq85zpTARVd0vS9MMgaAQi95mrVJi3xYCqbRYM4WO8FIXm5Cev4px0F3hyFFXKPzNF
         iaqw==
X-Gm-Message-State: AC+VfDxrWkQL+W6yHOlZKWi4mZrDE98HzJNOeBOfDwBME6xxc4f7Y74z
	NSLUmldgoVSCKAsaqT2TKfNJju3qcOzPoOTF92g=
X-Google-Smtp-Source: ACHHUZ7yJMnMY6FDtSd/XWCckyH6R1hVHPtnx0cMQkr5ACy51MJhHAgQHdS+UINbl7W7htBVtE0/6YOX5PV5R1UiKzQ=
X-Received: by 2002:a05:6a20:1456:b0:111:1bc4:cf0a with SMTP id
 a22-20020a056a20145600b001111bc4cf0amr9359163pzi.52.1687273113870; Tue, 20
 Jun 2023 07:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com> <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca> <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com> <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com> <ZJBf5DP60prFH5R2@nvidia.com>
In-Reply-To: <ZJBf5DP60prFH5R2@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Jun 2023 07:57:57 -0700
Message-ID: <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 7:02=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 19, 2023 at 11:20:58AM +0100, Robin Murphy wrote:
> > On 2023-06-16 19:59, Jason Gunthorpe wrote:
> > > On Fri, Jun 16, 2023 at 05:34:53PM +0100, Robin Murphy wrote:
> > > >
> > > > If the system has working ACS configured correctly, then this issue=
 should
> > > > be moot;
> > >
> > > Yes
> > >
> > > > if it doesn't, then a VFIO user is going to get a whole group of
> > > > peer devices if they're getting anything at all, so it doesn't seem=
 entirely
> > > > unreasonable to leave it up to them to check that all those devices=
'
> > > > resources play well with their expected memory map.
> > >
> > > I think the kernel should be helping here.. 'go figure it out from
> > > lspci' is a very convoluted and obscure uAPI, and I don't see things
> > > like DPDK actually doing that.
> > >
> > > IMHO the uAPI expectation is that the kernel informs userspace what
> > > the usable IOVA is, if bridge windows and lack of ACS are rendering
> > > address space unusable then VFIO/iommufd should return it as excluded
> > > as well.
> > >
> > > If we are going to do that then all UNAMANGED domain users should
> > > follow the same logic.
> > >
> > > We probably have avoided bug reports because of how rare it would be
> > > to see a switch and an UNMANAGED domain using scenario together -
> > > especially with ACS turned off.
> > >
> > > So it is really narrow niche.. Obscure enough I'm not going to make
> > > patches :)
> >
> > The main thing is that we've already been round this once before; we tr=
ied
> > it 6 years ago and then reverted it a year later for causing more probl=
ems
> > than it solved:
>
> As I said earlier in this thread if we do it for VFIO then the
> calculation must be precise and consider bus details like
> ACS/etc. eg VFIO on an ACS system should not report any new regions.
>
> It looks like that thread confirms we can't create reserved regions
> which are wrong :)
>
> I think Alex is saying the same things I'm saying in that thread too:
>
> https://lore.kernel.org/all/20180226161310.061ce3a8@w520.home/
>
> (b) is what the kernel should help prevent.
>
> And it is clear there are today scenarios where a VFIO user will get
> data loss because the reported valid IOVA from the kernel is
> incorrect. Fixing this is hard, much harder than what commit
> 273df9635385 ("iommu/dma: Make PCI window reservation generic") has.

I think this may have gone off down a rathole as my original question
wasn't anything about adding extra reserved regions. It was about
exposing what the IOVA is already reserving so it could be user
visible.

The issue was that the reservation(s) didn't appear in the
reserved_regions sysfs file, and it required adding probes or printk
debugging in order to figure out what is reserved and what is not.
Specifically what I was trying to point out is that there are regions
reserved in iova_reserve_pci_windows() that are not user/admin
visible. The function reserve_iova doesn't do anything to track the
reservation so that it can be recalled later for display. It made
things harder to debug as I wasn't sure if the addresses I was seeing
were valid for the IOMMU or not since I didn't know if they were
supposed to be reserved and the documentation I had found implied they
were.
