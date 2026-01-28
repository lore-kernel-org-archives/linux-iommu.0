Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF8EAE7
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588712; cv=none; b=cA5fc+ZFA6OcYV8YrCLyovbBp02Q3arJDPEardO+susLwcsvOZTOAPZseadqC5gkeLejK1+haEBeQvQcEBuPH0ybiu/8d3PRJTtvyD8sf6mzolacAzysJ/yVfZhoStjbVb1t15/vxOFTyaK2DCvqjqa8reOoggHX6q2yYBY+d9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588712; c=relaxed/simple;
	bh=bJJUAMf4S41c3tEpzm53CNa43pMkfgWa4UwG2TqC+Ps=;
	h=Message-Id:In-Reply-To:Content-Type:From:Mime-Version:References:
	 Date:To:Cc:Subject; b=gxx7aiXwwLFR1BgvMlxhbFltq2JIzRC+muAoXd3xvYRSrTXCvJ2XQKqV+vw+a9ip4dcZg3O6H5f7OJl3jDuafonF9bD4sECiXsDC3oBZgvSiRo/zvNI5i7V0bf1870R2ACCs0AP4WTj2YEH/d3e/RimrE0JR/Zx1tlKz5LJTm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=XGrfXJPC; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="XGrfXJPC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769588692; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bJJUAMf4S41c3tEpzm53CNa43pMkfgWa4UwG2TqC+Ps=;
 b=XGrfXJPCT2iTE6uXJw3xo5+ElSqAU0kn4XwV2FkgvyNvvb2ulVqsjG7GLBG5GeLF+Wvc1z
 406+snJhfpRvvWVdTmogyQF+d/gUZtK3GGGMTBUqD1jdul5iuNI7CiW0sAsrrtQ4wJrz0l
 TFyk++7k7LsK4nlkrG9OELBz0z3MYloupOF1Vifzp16gKwk4HyCWnQ9I/lGvf8ngXCDQnX
 6+39LD9MXX+XGfoWRlJe0w8gHk59QfbaXwnfImYdl05lxq8L/Lh0Ho8rwK2iEDsuoUcZnw
 /J0vtMQQhO9m/owSpiaFwzOKq9kry4vpJSKV7lt5KpQH6LLVQ7zE18FJfUiZ4w==
Message-Id: <a4684b7f094a6a5ee87d9db722b75594f851b9fb.2ae81df2.abbc.45e1.bb19.030f5f912961@feishu.cn>
In-Reply-To: <5caf9ea1-17b4-4fef-8ff1-f8d6b580f0b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?q?=E9=83=91=E5=BE=8B?= <lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cb4abe275a064f241fa54440608cd3240fb82284.1769562575.git.lv.zheng@spacemit.com>
	<5caf9ea1-17b4-4fef-8ff1-f8d6b580f0b3@kernel.org>
X-Lms-Return-Path: <lba+16979c7d2+3d4bf7+lists.linux.dev+lv.zheng@spacemit.com>
Date: Wed, 28 Jan 2026 16:24:49 +0800
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Robin Murphy" <robin.murphy@arm.com>, 
	"Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Jingyu Li" <joey.li@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 4/6] spacemit/t100: Add vendor event support for RISC-V IOMMU HPM

Hi,

> From: "Krzysztof Kozlowski"<krzk@kernel.org>
> Date:=C2=A0 Wed, Jan 28, 2026, 15:46
> Subject:=C2=A0 Re: [PATCH 4/6] spacemit/t100: Add vendor event support fo=
r RISC-V IOMMU HPM
> To: "Lv Zheng"<lv.zheng@spacemit.com>, "Robin Murphy"<robin.murphy@arm.co=
m>, "Tomasz Jeznach"<tjeznach@rivosinc.com>
> Cc: "Jingyu Li"<joey.li@spacemit.com>, "Zhijian Chen"<zhijian@spacemit.co=
m>, <iommu@lists.linux.dev>
> On 28/01/2026 03:24, Lv Zheng wrote:
> > This patch adds mechanism to allow vendor events to be registered via
> > device tree. This is useful to support SpacemiT T100 IOMMU where the
> > maximum 128 event IDs should be supported by T100 IOATS.
> >=C2=A0
> > Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
> > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > ---
> > =C2=A0.../bindings/iommu/riscv,iommu.yaml =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A04 +
>=C2=A0
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>=C2=A0
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
>=C2=A0
> Anyway, the property is NAK - does not follow any standard rules. Read
> docs in kernel about bindings and some DTS beginners talks/slides.

Sure, thanks for the kind reply. Will rework and submit again.

Best regards
Lv

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
