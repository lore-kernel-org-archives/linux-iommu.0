Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57A3242BD
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217067; cv=pass; b=fg1j59rm+8KgojpLSW9/WcEi9BSEpdClN0R7YvW0Tn8BnFLrvobpSd9cUcRJ4WIZFviatKSTcrSroxckNC2oo3Jx5XOn+oYJygaxRR454d81EYhqDiaazvqb72Cpwep6YVw1W7gX+4TFrZM4UEc67SSs+wFrykJVSshWtQtDkZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217067; c=relaxed/simple;
	bh=EsT5CPPb1bNgisa9Sf6hnMEjzfva7I39ro1rTJ6d3y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edlrpqQzheAV/yuhw6DxoumowNJGEyH+k/49TpCecV3NpV2Nojj8k+o/Nbp3dp7eQQtHaOsH3LyqJA5SJ37JqXVcG9Ij6YSbnwM+0/V6h3x7gY7sGTa45/Ns9A5lI6K4UaldprhLTb+y3z+6YOw9PeNGlX9ayQJafQzFQTzfnEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E6Azgdi4; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E6Azgdi4"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e33so1000032a34.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 19:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790217065; cv=none;
        d=google.com; s=arc-20260327;
        b=ooE1YCdCDCWB0RHOnoe+VIZjHgSzFTYOIH2DtXuuS0Qq1v4t5vZmrPdSQ8XxkwqaPd
         6mJF5f0KxNj5pgQzG64vILy2PsWvKjxNo++EVuKiwBaHT6aPZn2cshVeQLl1DAeAGHVr
         IbUxki1k82OuYbfHgFrCbRUAJ9grRuJYzRwP+ZZTWms3gCL3RsuZpXJr4nAwvr3stSqA
         W/Jpi+MwxIzEAezp2H028hqa5pp1WKj6gqTbFjLI5mY6jK678OYNJjUdKkotLWoIiuxh
         90VYzx9yYakOx0ZXW70uq+KcY+0ZaTiic+Xz4YivF8vo0KBI/k4sFSEuMlt/9Nw3KLNM
         lxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXkUAxHG2rDjGik19A3u7hnIdWNHsf8MjMKouetg/DU=;
        fh=N0SjlanWW2SGxLUG2LryCr/GyZnbFfvxFQJ6sTRfSHU=;
        b=Bbc9xdGnqPj1m9AHT5oQ+uTKBhnc1GF3BzH5n/MdVq77vCd1gG7Q2fa0aRnkmArQvs
         YBPMDfkMWdbRy78U7hFhXX5NKFE6vcmyJuRBWUUXzqZcseho1e07oIJCBDconJK7x5Vp
         fqN8fBZVmHuQyZSXDpXLhB05YXjkC+sh914J8Gw6TJj1Eh2Gkl5eq6hlS4RYoaAEb9W5
         uAdbUaPT3JmgamxNbBQ2L7Bl/cUrfKx0cNhl67QlIWwy2D9/j+WC4bMT2FTxtGkaomqf
         czbgUr44aPlTycfNPn9fpnxkBUyslfBuTDCNHVnTmMWHpfPJRwaKarTWE3+Vl5zXWqTl
         +jvQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790217065; x=1790821865; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXkUAxHG2rDjGik19A3u7hnIdWNHsf8MjMKouetg/DU=;
        b=E6Azgdi4nuGyJie/7tFXDzFM1Npys97+CQK64b8bcnl2UZEWeSLfEaPY1tzRy96Deq
         KNafE6kIUTGDXMsMpL/P7lWH5KRv0slID4OySphIMogIR2CNcBlsQmtxZ1wML4Y4Xjtc
         iyMjtT5Id/LO0CWrNsvLRBoER+x7LgCF0opHqc/nKZPdB9U54xcICaKJJcFfefQSEwkh
         awK3Hj+Loc16CEbIS/BtrNuhC7GWuoZp0eNuB0wDexenJot7K2ct3RPrwiRIXoCStciO
         ir2V+P07AGVCPwQLMeC9ASQp+/m7HmK/rQkzN8e0pJZuUbgg9R90SRcrV7vno8KX1j0h
         qxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217065; x=1790821865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXkUAxHG2rDjGik19A3u7hnIdWNHsf8MjMKouetg/DU=;
        b=G044R0kSRcoRaCi+FfBrAOhg9aqfrFGvw6Sr28Gi6PImkhOxaqAS/hcSM76efGJ/9L
         NKUxwkfo6ja5XtKBLtz9CSwBbnIKoAx2raGpk0eqeE637iypfv+6oJco0VTmmopSAasz
         98cA2Aq44RfSET8EEo1/UYbKunOj+tKCV76JT6bDk/n3dkt/NYK3asF1UGFDzP4ID6R1
         L06pUpkpQqplvBjcE15Kakru8PgU9K5bF0vn/PG8DPanH6PJFOhBXGoYxqlV7WOeBUX0
         DNrvT4ONOEqz7YwrqzDdrqwOj6guAImjPFfVKskdTlXhQ/EmDvADotqXfmcARa08AK0T
         7mjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTmn7D0lulN68S0JjHghUAe+CMq8+vkbMQsdnr+ptOuvJGhG6dK5LCjxSbcSYZgciL7Whaeg==@lists.linux.dev
X-Gm-Message-State: AFuF++k8xrsgo+EwhEu2+fcw8QzGTEDlfq+LU/B0EkydRBSrXwENJzgc
	1x6/7jsCLo9yD2tzu8rai5UxRxgZkeFp7P5g4GTApDAz61xz67q8HQGX4v799NQfwv77jlsC0Vj
	uN6FJiAyv/YNni5Yck3cGNonDW8gEXmYHPm5yrHH03g==
X-Gm-Gg: AYBFou3vGkhGMxqyVn0ZlpB0xtC+SQzSexVxWyAN0VAIqw5f5P7JX1kkiElKumU+X4R
	Jr65FG2BOI5gW4dvFahnC7q2zfFJd/941Gk52mJoe+3lmLFiVTG3VPzuBo56lxHnMBcEVYNIecv
	RcR2I3w/yOtwFAzIOSb9jRqLbGEu7lS8e4PRUhxtOor4c0zbVqqF4UFdSnOPwYazJyfoQt2mZuh
	O2JF2yNyholl5TBFuJOYqiZlrPdO6QNaz3J7StRcElyrJs6nvhdy2leCP/iGQlXKvpUkxseFOJu
	pQ68+pG7s6Giytvr+13wKkgDBtZop7m+ey3Nu7thF4zWJ8lh21RpjSKLTAkd
X-Received: by 2002:a05:6820:8108:b0:6b7:46fa:1696 with SMTP id
 006d021491bc7-6d43ff6967amr1221223eaf.43.1790217064435; Wed, 23 Sep 2026
 19:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <arKx__kOPe4B5gDW@agluck-desk3> <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
In-Reply-To: <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 24 Sep 2026 10:30:51 +0800
X-Gm-Features: AclHuK-vMCZ2qFyl77CbgGPIcIoNJvukIV1ifNLkMIWFcIgVYuepWIgdw3SPQcI
Message-ID: <CAEEQ3wkp1d13oDxO_kOVYGpgByPZENs8cNFnobi294SUbq7k6A@mail.gmail.com>
Subject: Re: [External] Re: Resctrl and I/O
To: James Morse <james.morse@arm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	babu.moger@amd.com, baolin.wang@linux.alibaba.com, ben.horgan@arm.com, 
	corbet@lwn.net, Dave.Martin@arm.com, fustini@kernel.org, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, palmer@dabbelt.com, pjw@kernel.org, 
	reinette.chatre@intel.com, robin.murphy@arm.com, shuah@kernel.org, 
	tomasz.jeznach@linux.dev, wangzhou1@hisilicon.com, will@kernel.org, 
	xiaqinxin@huawei.com, yuanzhu@bytedance.com, zengheng4@huawei.com, 
	zhangzhanpeng.jasper@bytedance.com, x86@kernel.org, iommu@lists.linux.dev, 
	linuxarm@huawei.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Thu, Sep 24, 2026 at 1:13=E2=80=AFAM James Morse <james.morse@arm.com> w=
rote:
>
> Hi Tony,
>
> On 22/09/2026 17:51, Luck, Tony wrote:
> > Patches for ARM[1] and RISC-V[2] are both at RFC status.
> >
> > They appear to be based on similar h/w capabilities where architecture
> > specific tags can be added to transactions from I/O devices by the IOMM=
U
> > servicing the device. Device enumeration is handled outside of the resc=
trl
> > file system.
> >
> > ARM docs say "the device name is the one listed under /sys/kernel/iommu=
_groups/<id>/devices/"
>
> I think using existing stuff in sysfs is a good idea.
> (Creating new things in sysfs fills me with dread!)
>
> ARM/MPAM also has platform devices that can add the CLOSID/RMID metadata.
> e.g. the GIC ITS [4] - a kind of translator for MSIs.
>
> For these we considered just using the device name as found in /sys/bus/p=
latform/devices/,
> in the hope that can be tied back to a struct device - and we could add a=
 callback for
> resctrl to configure the device with a CLOSID/RMID.
> (but - I've not seen a use-case for this yet - those devices generate ver=
y little traffic)
>
>
> Robin M set me straight on the iommu_group:
> Strictly that is the wrong abstraction as devices are in the same group i=
f the
> driver can't stop them communicating, e.g. PCIe peer2peer. This doesn't m=
ean it
> can't tell the traffic apart for CLOSID/RMID labelling.
> I picked this because its the device granularity VFIO works with.
>
> Equally, a device may create multiple streams of traffic, where only the =
driver
> will know what each one corresponds to.
>
>
> Using iommu_group like this may need a bit more thinking....
> If we can fall back to using a device as seen by sysfs, then the arch dif=
ferences
> here could be invisible to user-space.
>
>
> > RISC-V says architecture specific device tokens are "devices or device =
groups"
> >
> > In both cases assignments are made with:
> >
> >       # echo {device} > {group}/devices
> >
> > So now I'm looking at the capabilities of Intel RDT hardware. I'm ignor=
ing
> > the implementation on the Granite Rapids CPU, and looking at what is de=
scribed
> > in the RDT Architecture Specification[3]. Here are the highlights:
>
>
> > 1) Enumeration is split between two ACPI tables. IRDT enumerates device=
 groups
> > and provides MMIO addresses to assign CLOSID/RMID to each group.
>
> For ARM/MPAM - this would always be driver specific. The fields may be sh=
are a register
> with other things the driver needs to consider.
> The IOMMU abstracts this for its devices, but this is still something the=
 IOMMU driver
> needs to know about.
>
> A driver hook, with a drivers/acpi fallback would be ideal.
>
>
> Do you have arbitrary grouping of devices? e.g. a USB controller and the =
UART.
> Or would the grouping make some sense to the OS. e.g. all the USB devices=
 behind
> this port.
>
> Having the UART show up when you add a USB controller to a control group =
is a bit odd.
>
>
> > ERDT provides
> > MMIO addresses to read event counts for RMIDs and to configure cache al=
location
> > bit masks and memory bandwidth limits.
>
> Arm's IOMMU does have controls/monitors that match the spec the MPAM driv=
er needs,
> but we currently have no way to expose them through resctrl.
> The caches on the IOMMU are also relatively small - I've not yet seen any=
one show that
> setting the controls there makes a big difference.
>
>
> > 2) All I/O monitoring and control is with respect to I/O caches, not to=
 the L3
> > caches that legacy RDT features operate on.
>
> Do you have I/O traffic that can turn up in the CPU L3 cache? I think PCI=
e calls
> this 'cache stashing'.
>
> Arm's IOMMU is the same - but the traffic may also show up in the L3 depe=
nding on how
> the system is put together.
>
>
> > 3) The number of RMIDs supported for I/O is lower (maybe considearbly l=
ower)
> > than the number supported for CPU monitoring.
>
> MPAM can have this happen - and today it will sanitise the values to the =
lowest
> common value. Considerably lower becomes considerably upsetting!
>
> I'd be interested if we have an approach for this - the IOMMU designers w=
ould argue
> they only need one RMID per device - but the system wide sanitised value =
means they
> have to match the rest of the system.
>

  This lowest-common-denominator issue suggests that resctrl may need a
  logical CLOSID/RMID namespace that is independent of the ID space
  implemented by each hardware controller.

  A resctrl group would retain a system-wide logical CLOSID/RMID, while
  each resource or architecture backend maps those logical IDs to its
  controller-local allocation entries and monitoring counters. This would
  avoid unconditionally limiting the number of resctrl groups to the
  minimum ID count across all enabled resources.

  The current resctrl allocation model uses that minimum as the
  system-wide CLOSID limit, which is safe for direct indexing but leaves
  additional entries in larger controllers unused.

  On the RISC-V CBQRI side, we are discussing a hardware mechanism that
  could provide such per-controller mapping while requests continue to
  carry the logical RCIDs/MCIDs:

  https://lists.riscv.org/g/sig-datacenter/message/286


Thanks=EF=BC=8C
Yunhui

>
> For MPAM systems this shape is a big headache because on the platforms we=
've seen,
> the monitoring is done at the memory-controllers - so any RMID spaces get=
 joined
> up eventually.
>
>
> > 4) Monitoring events are I/O cache occupancy, total i/o bandwidth, and =
i/o miss
> > bandwidth.
> >
> > 5) Current revision (1.4) of the specification doesn't include details =
of
> > I/O memory bandwidth control (The "IBAD" subtable of ERDT is reserved f=
or this).
> >
> >
> > Fitting this into resctrl
> > -------------------------
> >
> > RISC-V description of "architecture specific device tokens" sounds grea=
t.
> > I'll have to find some ares of /sys to provide the mapping of tokens to
> > "device groups".
> > There's no association with IOMMUs, so this will be some
> > other path in /sys. Perhaps under /sys/firmware/acpi since the data com=
es
> > from ACPI IRDT table.
>
> What about using the device behind the IOMMU instead? Presumably the kern=
el
> could allocate ids that don't clash with those in the IRDT, and use those
> for the IOMMU.
>
>
> > Need an info file to tell users the format and source for device tokens=
.
>
> I'd prefer we have one consistent way of doing this across architectures.
> Especially if we're going to add something new to sysfs.
>
>
> The sysfs path probably covers all bases - but I wouldn't want to parse t=
hat
> in the kernel.
>
>
> > I'd like to avoid limiting resctrl monitoring of CPU activity due to th=
e small
> > number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data=
/{i/o
> > events} files in resctrl group directories when rdtgroup::mon::rmid >=
=3D
> > num_io_rmids? But that feels clumsy.
>
> I had a half baked idea on how to do this. (which Ben has poked some hole=
s in)
>
> Assigning a device to a ctrl/mon group needs to be able to fail. We can u=
se this
> to re-allocate the RMID into the range the new device can use. The CPU ta=
sks can
> be repainted to use the new value - but the obvious problem is the old da=
ta in
> the caches that uses the old RMID.
> As no new traffic will be generated for that RMID, it might be possible t=
o keep
> it associated with the ctrl/mon group (which would now have two RMID) to =
keep the
> user-space view of the counters correct until the old RMID falls below th=
e
> reallocation threshold, and it can be free'd.
>
> It's worse if we ever needed/wanted to do this with CLOSID. Two CAT bitma=
ps
> can be configured the same - but MBA doesn't alias in the same way. Tasks=
 would
> be able to burst higher than the configured limit - but the size is limit=
ed by
> the size of the caches. And if no new traffic can be generated with the o=
ld
> CLOSID/RMID, then the effect can't be made to last forever.
>
>
> For a totally wild suggestion (that I don't think works here) - I had
> mooted having a second mount of resctrl for islands of the SoC where the
> properties are different. I don't think it works in this case as the IO-R=
MID
> presumably gets seen by some other monitors later.
>
>
> > Domains are based on I/O L3 cache instances. So a new rdt_resource with
> > new line in the schemata file for IOL3 cache masks per domain. In the
> > future when there are I/O MBA controls, new line(s) for those too.
>
>
> Thanks,
>
> James
>
>
> [4] https://support.arm.com/documentation/ihi0069/hb/?lang=3Den search fo=
r "MPAM" in the pdf.
>
> >
> > [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqin=
xin@huawei.com/
> > [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.j=
asper@bytedance.com/
> > [3] Linked from the bottom of https://www.intel.com/sdm under "Related =
Specifications", or
> > direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=
=3D1158389_ts1790091453223
>
