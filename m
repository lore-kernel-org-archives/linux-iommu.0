Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BF12B71
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684773869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW2LyuY7Znrs2BmHTDe8qJ3Pf/3rmibkdu2EhgvDatE=;
	b=eCCZFEM0LnG++tgA65YDIx7jvDzpeTt/I0lDAQ78w0frJoNM1FzWJLMH6wecgpnbie6WCa
	s66qKkSfupQkgHDumF6Lf7B7j/X0XINnQpkBXVDl9BUCx8GaJ+bkBuzR6J3OliocnuSm9Q
	6ziaIbXfFSi4JHLW4NPKtrjplx9XshA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-uymp7_XYM5O1C6mcJQWwWw-1; Mon, 22 May 2023 12:44:26 -0400
X-MC-Unique: uymp7_XYM5O1C6mcJQWwWw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3381796d685so97942095ab.1
        for <iommu@lists.linux.dev>; Mon, 22 May 2023 09:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773865; x=1687365865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5xLlyF6fbpaSXnlf8tFIuiWzedzwNQSadFf+qnr7H4=;
        b=HkdKO+Fd7qMw0JBu5/fi1W0E/hDbtKEl3RxGWxVSoCHI00EkLBPEh72YtL9nIfZfEL
         P6rfv6V6DLzG3h2aW+E0ysD0J0gbiLI1A7OVT7VReawoA+Ed+lAd3PzfTceMv9N3ILcC
         WeFq09SF0Aj1pkLffAqjT9OVPc6Yy5zXdloQElAwvyZ4lE98ZC72Tf+Ld+Gq4AqsTUuY
         6WwLAokheeJ5wO/drvUxSYM59BJJ4h4m7QqNPVEiS09vfdMEe6KtQ2N81LB7Y29xDcb3
         itmZ1Riv+ttwfPBIgyi8T2S2WT/DqZJ5qLMd7fl0U3ybc+uok4egZBSA3cVrGMJqoKk1
         vX6w==
X-Gm-Message-State: AC+VfDwJ7oW6rXyrDmbHf7vfrw4ooaz5d2JLXBgXgpEPDIe/3D3//qyK
	jsNYof93sQRnLVsyzXi7F2VtEuefMVy1vCx2Mf/S9oZXQ/NwoJCK+Um4KF5ZGsvzWteCPV/1lNu
	LYcL9EPJlDy4uBOHbR7QfHYM=
X-Received: by 2002:a92:d84f:0:b0:331:53ee:921d with SMTP id h15-20020a92d84f000000b0033153ee921dmr6842579ilq.25.1684773865014;
        Mon, 22 May 2023 09:44:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nkKPaRrlcl83u4yYaceR/8FdvHxOyPCDaxRIFntqHUqtQWGVJdMT6fZkK+m9kV4rseONigg==
X-Received: by 2002:a92:d84f:0:b0:331:53ee:921d with SMTP id h15-20020a92d84f000000b0033153ee921dmr6842571ilq.25.1684773864605;
        Mon, 22 May 2023 09:44:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q9-20020a6bf209000000b0076ca45ebfc4sm2015043ioh.14.2023.05.22.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:44:24 -0700 (PDT)
Date: Mon, 22 May 2023 10:44:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, bugtracker@fischbytes.de,
 iommu@lists.linux.dev
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Message-ID: <20230522104422.1ae39d78.alex.williamson@redhat.com>
In-Reply-To: <c36e755a-416a-cf50-57fb-78438a2f61db@arm.com>
References: <2282218.ElGaqSPkdT@helios-lx>
	<4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
	<1877598.tdWV9SEqCh@helios-lx>
	<302501af-05a3-9757-d923-602ad9a6d9c9@linux.intel.com>
	<c36e755a-416a-cf50-57fb-78438a2f61db@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 May 2023 12:42:51 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2023-05-16 02:13, Baolu Lu wrote:
> > On 5/13/23 9:11 PM, bugtracker@fischbytes.de wrote: =20
> >> On Saturday, May 13, 2023 8:20:40 AM CEST you wrote:
> >> =20
> >> =C2=A0> On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote: =20
> >> =20
> >> =C2=A0> > Hi there, =20
> >> =20
> >> =C2=A0> > =20
> >> =20
> >> =C2=A0> > I came here today to ask if there are any plans regarding th=
e =20
> >> =20
> >> =C2=A0> > implementation of a "relaxed RMRR" kernel parameter to aid u=
sing  =20
> >> IOMMU on
> >> =20
> >> =C2=A0> > broken platforms such as the ProLiant Series by Hewlett Pack=
ard =20
> >> =20
> >> =C2=A0> > Enterprise. To everyone not aware of the issue; =20
> >> =20
> >> =C2=A0> > =20
> >> =20
> >> =C2=A0> > Certain vendors that are under the assumption that standards=
 are  =20
> >> for jerks
> >> =20
> >> =C2=A0> > and Intel's specifications are a loose optional guideline ha=
ve =20
> >> =20
> >> =C2=A0> > implemented RMRR in such a way that every PCI device is mark=
ed as =20
> >> =20
> >> =C2=A0> > reserved and therefore cannot be passed through to a virtual=
  =20
> >> machine.
> >> =20
> >> =C2=A0> > This issue has been very well documented by some people that=
 have  =20
> >> a lot
> >> =20
> >> =C2=A0> > more experience than I do at the below linked resource. I wa=
s  =20
> >> hoping that
> >> =20
> >> =C2=A0> > the kernel devs could implement the Relaxed RMRR option as a=
n  =20
> >> optional
> >> =20
> >> =C2=A0> > kernel parameter to use on these bugged platforms as that wo=
uld  =20
> >> re-enable
> >> =20
> >> =C2=A0> > or rather enable a lot of broken servers for the first time =
ever  =20
> >> to use
> >> =20
> >> =C2=A0> > PCIe Passthrough. I can verify the issue exists on a HPE DL3=
60e  =20
> >> Gen8 with
> >> =20
> >> =C2=A0> > trying to passthrough a GPU to a KVM/QEMU machine. =20
> >> =20
> >> =C2=A0> > =20
> >> =20
> >> =C2=A0> > Link to fix: https://github.com/Aterfax/relax-intel-rmrr =20
> >> =20
> >> =C2=A0> > =20
> >> =20
> >> =C2=A0> > Furthermore, since I am not a developer and wouldn't claim t=
hat I am =20
> >> =20
> >> =C2=A0> > competent enough to decide whether or not implementing this =
patch  =20
> >> would
> >> =20
> >> =C2=A0> > present an issue in terms of stability or security, I was ho=
ping  =20
> >> that you
> >> =20
> >> =C2=A0> > could evaluate the situation. I can verify the pre-built pac=
kages  =20
> >> for the
> >> =20
> >> =C2=A0> > Proxmox Linux environment fix the issue and behave identical=
 in  =20
> >> function
> >> =20
> >> =C2=A0> > to other systems that ignore RMRR completely, such as VMWare=
 ESXi. =20
> >> =20
> >> =C2=A0> > =20
> >> =20
> >> =C2=A0> > Thanks alot in advance, you implementing this patch would re=
ally  =20
> >> mean a
> >> =20
> >> =C2=A0> > lot, since the hardware manufacturers just don't seem to car=
e for  =20
> >> fixing
> >> =20
> >> =C2=A0> > up this, erm, mess. =20
> >> =20
> >> =C2=A0> =20
> >> =20
> >> =C2=A0> The relaxed RMRRs are used for legacy purpose, but it requires=
 the  =20
> >> full
> >> =20
> >> =C2=A0> range of memory addresses are available after the OS device dr=
iver  =20
> >> takes
> >> =20
> >> =C2=A0> over the control of the device. =20
> >> =20
> >> =C2=A0> =20
> >> =20
> >> =C2=A0> Not all RMRRs are of this type and typically the VT-d driver o=
nly  =20
> >> allows
> >> =20
> >> =C2=A0> those RMRRs for USB and graphic devices as relaxed ones. =20
> >> =20
> >> =C2=A0> =20
> >> =20
> >> =C2=A0> Are you proposing to add a kernel parameter to allow any RMRR =
for an =20
> >> =20
> >> =C2=A0> arbitrary device to be relaxed, or I didn't get the idea here?=
 =20
> >> =20
> >> =C2=A0> =20
> >> =20
> >> =C2=A0> Best regards, =20
> >> =20
> >> =C2=A0> baolu =20
> >>
> >>
> >> Correct, the idea here is that, while this observation can only be=20
> >> made on specific hardware, it more often than not occurs that devices=
=20
> >> that definitely shouldn't be (like e.g. GPUs attached to the PCIe=20
> >> Interface) are marked as reserved by offending firmware. A perfect=20
> >> solution would of course be to force the hardware vendors to push a=20
> >> firmware update that resolves the violation of Intel's specifications,=
=20
> >> but such a thing doesn't appear to have happened in the past and it's=
=20
> >> very unlikely that, let's say Hewlett Packard Enterprise, will ever=20
> >> release a firmware update for those thousands of broken servers.
> >>
> >>
> >> (Quoted from here;=20
> >> https://github.com/Aterfax/relax-intel-rmrr/blob/master/deep-dive.md#r=
mrr---the-monster-in-a-closet ;
> >>
> >>
> >> /Intel anticipated the some will be tempted to misuse the feature as=
=20
> >> they warned in the VT-d specification: "RMRR regions are expected to=
=20
> >> be used for legacy usages (...). Platform designers should avoid or=20
> >> limit use of reserved memory regions"./
> >>
> >>
> >> /HP (and probably others) decided to mark every freaking PCI device=20
> >> memory space as RMRR! Like that, just in case... just that their tools=
=20
> >> could potentially maybe monitor these devices while OS agent is not=20
> >> installed. But wait, there's more! They marked ALL devices as such,=20
> >> even third party ones physically installed in motherboard's PCI/PCIe=
=20
> >> slots!/)
> >>
> >>
> >> Hope this could clarify my inquiry a bit more. =20
> >=20
> > Thanks for the information.
> >=20
> > This Red Hat white paper explains why RMRR is not supported for device
> > pass-through.
> >=20
> > https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
> >=20
> > I am concerned that adding a kernel option to release all RMRRs blindly
> > could be harmful to users. Some users may not be aware of how RMRR
> > impacts device passthrough and may only use the option because they
> > find it will help them in some use cases where it's impossible without
> > it. =20
>=20
> Agreed, I would be very uncomfortable doing anything at the IOMMU API=20
> level to override firmware information. Not to mention that doing=20
> anything at the level of individual drivers is plain impractical when we=
=20
> already have at least 4 of these mechanisms (Intel RMRR, AMD IVMD, Arm=20
> IORT RMR, and now the generic Devicetree binding as well).
>=20
> The thing to propose, if anything, would be not messing with the=20
> reserved regions themselves, but adding another "I know what I'm doing=20
> and I accept responsibility for picking the pieces up if it breaks"=20
> control at the VFIO level to permit assignment in spite of them - it=20
> feels like it's probably somewhere in between allow_unsafe_interrupts=20
> and noiommu mode in terms of potential impact, so doesn't seem entirely=
=20
> unreasonable off the bat.

I'd more likely put this in the same category as the ACS override
patch, which we've rejected from mainline.

In the case of the unsafe interrupts option, the risk is a malicious
guest exploiting arbitrary interrupt vectors on the host.  I certainly
wouldn't suggest this opt-in for a virtual hosting service, but there
are a good number of use cases where it can be a relatively safe
assumption that the guest OS has not been subverted.  Unlike RMRR or
ACS, an exploit of this vector more likely resulted in a denial of
service rather than a potential for silent data corruption, and had
there not been an opt-in, it would have broken the majority of x86
device assignment cases at the time.  It's also telling that this
option, which is all but irrelevant on any remotely modern x86 system
now, still appears with some regularity in vfio related guides, forums,
and bug logs.

OTOH, noiommu is an entirely different beast.  The argument for noiommu
is that certain environments are making use of direct DMA programming
of devices that are not protected by an IOMMU anyway, access to
/dev/mem and pci-sysfs enables this given sufficient privileges.  The
gap that vfio noiommu filled was MSI interrupts.  We'd generally like
these use cases to move to proper IOMMU protected vfio environments
anyway, so the goal here was to make that transition easier by waving a
carrot for making use of the vfio device interface with MSI interrupts
rather than extending uio-pci-generic beyond what it intended to
support.  Importantly, vfio noiommu taints the kernel (introducing
logging of these use cases), requires access using a different device
file (requiring userspace, as well as kernel opt-in), and provides no
DMA translation (ruling out more common use cases like VM assignment).

Much like what appears to be the history of this patch, the ACS
override patch has lived a life beyond its initial mainline proposal and
rejection, it's even been included in a few downstream kernel builds,
but none of the mainstream distros AFAIK.  My observations of its use
cases in various communities suggest to me that it was the right choice
to reject it from mainline.  Like the unsafe interrupt option above,
making the option sound scary or logging warning in dmesg does not
ultimately have much affect in an average user's choice to enable these
sorts of options.  On the contrary, we might speculate that had such
workarounds been so readily available, would we have as many ACS quirks
as we do now, would vendors have moved away from RMRRs?

It's unfortunate that there are generations of server lines that have
such a barrier to these sorts of use cases, but ultimately we still
cannot vouch that it's safe to ignore RMRR requirements imposed by the
firmware in these systems.  Including such options in mainline provides
a certain degree of validity in these workarounds that we cannot
support.  Therefore, I'd not be in favor of a user option to ignore a
firmware directive like this in the mainline kernel, especially to
enable a system that's potentially already a decade old.  Thanks,

Alex

