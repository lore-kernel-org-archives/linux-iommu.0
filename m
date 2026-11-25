Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795600891;
	b=vatqZx9AxzygCv5N4FwsU4hE3x+stvgbAuVbLroVo8pmtCuIGytD5CfNvFo2kVRX29Jw
	 UJOG6vhPHNQz9N2VPRCjXzZD9IMxe79QQ0mMwITMa3cMBDV1kGT/Ewi+/VvbIRSS5oNNN
	 JfOX8NA/11lOT7LCEkyaTCNmCLvGYRKUm7zcDxtsa0+IxHxkeUht7EiVqSzZinRgSZ0ao
	 Cs7qyHoCdHwdqSNkiyluAWSuM2bor6+V+IIFAWzxpsihywCJerlvm46KoOlVHiejsFQXS
	 xZhFgrNzZi27OH8py+PfOX+6OEL/EUVuL7ZHHulVYz1RHFHTAQyRYdqMFHuACxiZ2/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
	b=Rbykts89okNSxlO3vKE9b8NA+lfcyn/ohtN/vInixbES4JCHWeNyBKy8jp8WX13o4gHX
	 Ce+NsWQGL2qtfTH2uRj/i7gW5rWlCGcflWuMCnxCeu6/JP4bxU7RCE2hBumT1Vc9i6zJn
	 oNbURRVkk9I+d1rQSEUZnIDJHMNi4hTKawl9VEMhYUlytQB+8LkWCRFJReBgHPHUor/YR
	 kPErQwAAiJGaieP4OiadmTXYAuhnCRX2ZAxx3Jm8CYzGReFQDMwlBC5IZ1TCp39txaV7j
	 gLl0IybLTleXzPQ4xMFK2ppTVVdUUEa+FP+IJDPdXmdWZkfT3Y22LGv4ep4ely64bsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoL3qjDP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923C606A31E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 10:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5923C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoL3qjDP
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38431138772so7176664eec.1
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 02:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795600890; cv=none;
        d=google.com; s=arc-20260327;
        b=YT5C1/LQiNfvFs19UJHo27smsPgl42SNApu9CwL7xvSMiwdjQ9nx5H4hayVwVS43V+
         dUIQj2lChnIA8eAJUhqIk7jC3Bl8HrAhZJCWKrAcX0djnsPcT9OFiHJAu7Q/T1hSVHs2
         Skec/ofpUftq8BYdbFufvLYYtghSR85RUh1kgePyjx1Pg2Y/ojVU4KvNj3tJdak0yaWU
         8h2jtkqtcKFH8uALS92tFXSZPSFrEbZaii4zwyUhR9j7tSCKrMh8/EPQV+niGMuyAxzb
         nKEQIxWvx0Fs2AImUxmSWoW74HXLu9xYJFCnjwko4yMNPA+sKQYnYNJtUYtSKH0vo6KF
         t/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        fh=STY0UwL4CfinZYcBYSb6efFSIGtJP0pSKb5NtthMHc8=;
        b=DE+v8UqgUOSYTEL9mgVjjR29JSAeQC/rAFMo2KWFNzyrcuujxu5r/6MEYlymz+HYrK
         mEyiXh7RD5yMg40bMjiqvR/Drv9QY1GT6vzHKTBxb8zupZbRG8kZ8c3pJHS4bn40Cxf8
         n1eOj0b2/0q/xiOVNzrD3GdlBpuZTFy7u1moMZNiZS80AeIiKtP8tU0hswC/yQ0xLNu5
         bLuPo4hOkvO4u4w6juKTiI1GSxFwR9E7924cPZKHYRBeRs3/oqqha6OyYg//zg5eNX3K
         0IadYPBsLXwfRUgE5k/Qy1tXOdBhNYxU17DWjz/w84p5bwpX42hfKfag9sHBUWYLSRJ1
         Sbyw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600890; x=1796205690; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        b=yoL3qjDPHn0fH4za2j/DOJ9SHEYvll89iTvalDDIHO+0B945AZF5iRii2NWHF27L4e
         s0F2oLlJtP6rZPC8GesZte6/ShRWtIbZJnv+serGrlVUPexXI9q3+37gaQ2N/ZgQ3YVm
         9x5rPZHv4pDCotGeob8D+kzuH5xRxyd7NQ3DnXGbkEdtNn0J5To6df8MlMH74FZObhL0
         juRnWonUYrOXnmT3BbKXR7cwAkjzpHUl35ncnYKL/TOECrNwyVVQ4NrjNsozPvkIeplw
         diPwhBGugORgKwh4IKgdSRk8WcWSUVJnYs3mAsmaK/IQrXlioFu1ix/lG7IaN99/ELp9
         WNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600890; x=1796205690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        b=zCZ9ZtOuaQ3O7oqAHX3eYQwqZMAklQv9yZvocdjxthguXvWx4VkJHb8Po9yQhRspIc
         iEDaZo4hP5S5WDGtCYECqDR+LxtX7M+SYfxqDrY14xpB2+YNPrMi2WSIu8Fpd/MvBlu3
         HBO8oW6qvCfHz79S+88YrmMkI4OZdSpO7rQ7VrLEtmQqeVjTTsgDq22llcvy5tOthbUB
         WxBLzSRY7dt88hf0LrtLW7p2lXDRtBy+JgHTOahS03PWvDak12kKXUWH5Nmx/XV3QdV2
         nKd4N+I8sggO6mw7M4Zva7djYeUc9f/wuwAcq9XX9f1qYM+mU6LHYuFbAvW8RH7LhnuR
         fLNg==
X-Gm-Message-State: APuU4Z8cuHThP0ndbD7FPQKRyKFlNFTjOSpo2rjEG1FKM38Llm2L8orE
	eU39SFb2iRP47rA6To9MXX1Eh/6Lun/gOr7vXvMLBn7Ki6Tur5h5zDX1rXvsoIRtZyoqVIbtDgq
	8j/qw5JaFtizxIYQVXUnFbjl5xoSeQko=
X-Gm-Gg: AZFdTZd5kg7pbbCFoGVvZJdiPCx38YDcHUeuygCV7G7cGFEnM2nfivvZSXeGeska7Jj
	xuadg6v2OD3lamsNQseGGCPq+JY4FjyczzA++PP9Hz9g2DSBWwNCVR1Mb7cZ/ilcObE9TtogqCU
	2hBecawVGz1Vdr7DCrLBpPWrRIJ/efDoCwPobcFpcRhd6ioJTAvDPjE4XrmkNI/qclZMzHT6kb8
	dFYwq/tNoSY8DMgLHP62Y/Nx181DTsw2x0osKlpsKlGth0gyqzM/EOcdCGRqEn0wU2G7TEilzXm
	9rZjm28W4fitnn0lAZVftI9YEIhIeBd/B22Rib8nkpCK5gwL9qwCb6/Z2iOZMR0FTn3vZ2FkqWH
	Hft48KIyUa16NDShc3gEx30P+fYYq0pvOxFnk
X-Received: by 2002:a05:7301:dd8b:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-38571510675mr19622055eec.33.1795600890367; Wed, 25 Nov 2026
 02:01:30 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen>
In-Reply-To: <awX_cNOqtTjAP33a@ryzen>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 11:01:17 +0100
X-Gm-Features: Aa3M54ouYqv21AOU9bWmU32JsLWokXrHwGO0cLR9AEzpEGq_IOCrbC6QpcKWpwA
Message-ID: <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for the pointers.

bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 shows
"DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is inside
the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its 7.x
symptom is the same "Emask 0x40 (internal error)". Their bisect of the 7.x
symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu page
table"), but the RMRR overlap is there long before that (they saw the
PTE error back to 6.0, and I see it on 6.12). So my guess is that
d373449d8e97 only changed how the overlap shows up.

The H97 thread looks different to me. There the faults are "non-zero
reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they depend
on the request size.

sp_off: on this machine the only DRHD reports no superpage support
(cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
anything. I tested it anyway:

7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR errors
and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
(zeros), and the iommu:map trace again shows 21 maps with
iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.

Thanks,
Peter

On Tue, Nov 24, 2026 at 10:19=E2=80=AFPM Niklas Cassel <cassel@kernel.org> =
wrote:
>
> Hello Peter,
>
> On Tue, Nov 24, 2026 at 07:08:13PM +0100, Pe3k wrote:
> > Hi,
> >
> > On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
> > 04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
> > firmware declares for it. With the default translated DMA domain this
> > corrupts disk data on every boot under write load. iommu=3Dpt avoids it=
.
> > Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.
>
> You are not the only person who is having problems with HP ProLiant
> MicroServer Gen8, see:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221713#c16
>
> There is also:
> https://lore.kernel.org/linux-ide/5ad27a97aafbc08a8702d5b90d09cd59@posteo=
.de/T/#u
> which I'm not sure if it is the same or a different IOMMU issue.
>
> Does:
> intel_iommu=3Don,sp_off
> on the kernel command line workaround the problem?
>
>
> Kind regards,
> Niklas



--
