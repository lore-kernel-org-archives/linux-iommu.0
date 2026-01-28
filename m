Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA5222565
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588619; cv=none; b=ZCXtn5Ef5CnUaeWGP9fMmD48Lr830QZdpZ8WE/5cQwo1V0iqGtN6ikiBIF0I+cqq1DKja8HpmaYW2K1AZxOpwn+SZrlxhA93u/9u2lSN6RzO666QFzlqMlNHujfhR2pLKFqd3QzgMmtRLlRShgr77Zkkbe7x00MuRknkcjjuRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588619; c=relaxed/simple;
	bh=ra8KNPg9YDCXJYrYtNkZX6YGu3yt+J+mfgBga6VH5kw=;
	h=Cc:Subject:References:In-Reply-To:Date:To:From:Mime-Version:
	 Content-Type:Message-Id; b=EGNrymOO2NbcJ6kEdJtEloeiVmtB6wQLiMA9Kt3wpJx/KpJYo4qw6lUifXQ3l16dYdsSfIGjfMXYGhKOB6wi++nqA6iMiVWxUMLb+9njJp749wshsQpO7ekZj9Ox164shJLFWdhKFKl+tlPMO42TKRtED/UoOulchl0tja9FcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=PjYjrJwE; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="PjYjrJwE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769588600; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ra8KNPg9YDCXJYrYtNkZX6YGu3yt+J+mfgBga6VH5kw=;
 b=PjYjrJwEnBTs3SKO5RM6az5WvdF3kbrUqQ7TOiFgfyDs5u10cf3MzqCC4LkbZz9UAZtObz
 4sVMANzzG6mMWP9Fm1UcflJ3nflFZZk8j2uBchGFKjW9RmKY9MChC+MkE89YlXKkiRQage
 imuCvgkHWwSRgibRjnHJqe93er573+q6lP6OL5v/BKzVb7IJkF19kiwFvFefAiffDYgeWp
 Ft7EzW0eUrO+klljKH8pBDzZm5ElKSyY4RUQHynz0+o2rpcgtiax8qggMQD38e0X5fg21J
 CJ43p6JzO5f1E36KZFxRk10fvS+3j5fTOMahTxFMGyeCOyLm3mH/akm5Do/ZSA==
Cc: "Robin Murphy" <robin.murphy@arm.com>, 
	"Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Jingyu Li" <joey.li@spacemit.com>, "iommu" <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] spacemit/t100: Add global filter support for RISC-V IOMMU HPM
References: <cover.1769562575.git.lv.zheng@spacemit.com> <aef97d98028a9e9a26de844990debfc0b414c2dd.1769562575.git.lv.zheng@spacemit.com>
	<b169f461-ee74-4592-9d2a-b25a1478e135@kernel.org>
In-Reply-To: <b169f461-ee74-4592-9d2a-b25a1478e135@kernel.org>
Date: Wed, 28 Jan 2026 16:23:17 +0800
To: "Krzysztof Kozlowski" <krzk@kernel.org>
From: =?utf-8?q?=E9=83=91=E5=BE=8B?= <lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16979c776+4d344f+lists.linux.dev+lv.zheng@spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <a4684b7f094a6a5ee87d9db722b75594f851b9fb.a29bb0cf.146d.44fe.9433.61cc415a421e@feishu.cn>

Hi,

> From: "Krzysztof Kozlowski"<krzk@kernel.org>
> Date:=C2=A0 Wed, Jan 28, 2026, 15:47
> Subject:=C2=A0 Re: [PATCH 5/6] spacemit/t100: Add global filter support f=
or RISC-V IOMMU HPM
> To: "Lv Zheng"<lv.zheng@spacemit.com>, "Robin Murphy"<robin.murphy@arm.co=
m>, "Tomasz Jeznach"<tjeznach@rivosinc.com>
> Cc: "Jingyu Li"<joey.li@spacemit.com>, "Zhijian Chen"<zhijian@spacemit.co=
m>, <iommu@lists.linux.dev>
> On 28/01/2026 03:25, Lv Zheng wrote:
> > This patch introduces global filter support for RISC-V IOMMU HPM. The
>=C2=A0
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submi=
tting-patches.rst#L94
>=C2=A0
> > global filter can be seen in SpacemiT T100 which only supports single
> > filter to be applied to all event counters. This silicon design can sav=
e
> > the number of the event bus signals.
> >=C2=A0
> > Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
> > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > ---
> > =C2=A0.../bindings/iommu/riscv,iommu.yaml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A02 +
> > =C2=A0drivers/iommu/riscv/iommu-hpm.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 93 +++++++++++++++++--
> > =C2=A0drivers/iommu/riscv/iommu.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 +
> > =C2=A03 files changed, 89 insertions(+), 7 deletions(-)
> >=C2=A0
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > index b69109362b20..ec5b84ff5afb 100644
> > --- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -72,6 +72,8 @@ properties:
> > =C2=A0 =C2=A0 =C2=A0minItems: 1
> > =C2=A0 =C2=A0 =C2=A0maxItems: 120
> > =C2=A0
> > + =C2=A0global-filter: true
>=C2=A0
> NAK, absolutely pointless and wrong code. I am not providing you full
> review because you did not bother to follow basic steps required from
> you, so essentially you waste our time.
>=C2=A0
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.

Thanks for the reminder.

I've been away from the community for too long time, and this is my first
time submitting driver patches with DT updates required. Sorry for the
basic mistakes.

Will re-work and submit again. My appologies.

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>=C2=A0
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.

Sure. Will loop to Will and Joerg in and probably with perf community inclu=
ded
for acknowledgement.

Best regards
Lv

>=C2=A0
>=C2=A0
> Best regards,
> Krzysztof
>=C2=A0


This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
