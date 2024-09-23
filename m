Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49819146E
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094803; cv=none; b=NtOy0CLEm0m51P5kMjDqk19Zn59XEhpSW9fjPW3nIxVxS5fnr2kQa1+Ea6b4HUw84GtKLfk6ypPNMF8332KCNvLGl5/62ZYnO2A7r+1whRivk9+Qpdtjl+cO7MFhCifMThSTeCUBgd/0why/Mb/o9Q3IWLWQXAaQVeCpGfV7haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094803; c=relaxed/simple;
	bh=88e05HCj0n1bVW724b0Ega9MRamOJEizX6uLJ6nZgGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeRK0g863uVNHf7fS6ysPJwtYUiG8YjNwhgn2Kh+xCKfy6rUhypPyMCbmW4675uWSuSX8+2//s7U415zMssg9x/ofOpKcWD15C+HBxxENbf0UhoVOg0xh09Qh65n7nt7Ddl/vAvzdz6Fc01J/1JF+Jy51VjFDLjATbrg6lf6Yyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SNIsAzhF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SNIsAzhF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N6xr2R015492;
	Mon, 23 Sep 2024 12:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	rV2XjpM7JhXLCO+km6oe2GD2bEJBsUC4gQ6vOFI6Htg=; b=SNIsAzhF/qfOw/zM
	rRHmNbVi8KuNJIbnvLWjKoYpi06WUWg95IXHNInsu22/B1QNJTlRvjZVdRXmL0ZP
	XxY482dnypbYlAZyuRwJvQQl7UFut/S23FN+TGWrDtrQ1ON4xLLD3bCcOfGWvcWq
	P+466EBmRLWEoOFy1X/JydL/iRR0xz3d+wlcc4/+cIhEvaSMeb72Ji3X6JGw8ydt
	9kcFEtRM14dT8scZoj+KCBK/abDOjmy8RIwxPVykoqymvWYDn2llP9LfpoVtsB7i
	oJv+dvCkVeEqnNxJQwVkASLEqNGynRC5xF3sbfobfXCxk8Uiftr15oH6twMj/BVA
	NKjwmg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjkmnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:33:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCLovT020820;
	Mon, 23 Sep 2024 12:33:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62x5bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:33:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48NCX8NR52494726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 12:33:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA51B20043;
	Mon, 23 Sep 2024 12:33:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E9220040;
	Mon, 23 Sep 2024 12:33:08 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 12:33:08 +0000 (GMT)
Message-ID: <7527fbe7e10a1490f14852a283c86cb5a20d034f.camel@linux.ibm.com>
Subject: Re: [PATCH v2] dma-mapping: report unlimited DMA addressing in
 IOMMU DMA path
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig
	 <hch@lst.de>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>,
        Xi Ruoyao <xry111@xry111.site>
Date: Mon, 23 Sep 2024 14:33:07 +0200
In-Reply-To: <4f37251f-b1a5-42e6-9680-beb0606659fc@arm.com>
References: 
	<c2671009f217bfc3c9f7fbda2eefb0c44768fc3b.1727028402.git.leon@kernel.org>
	 <31152f4714c644584db1e7e2506d0b434dff3fbc.camel@linux.ibm.com>
	 <4f37251f-b1a5-42e6-9680-beb0606659fc@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _gLEcnpz0Rz3MHX3pcAYXpWUYMqthzli
X-Proofpoint-GUID: _gLEcnpz0Rz3MHX3pcAYXpWUYMqthzli
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230091

On Mon, 2024-09-23 at 10:50 +0100, Robin Murphy wrote:
> On 2024-09-23 10:34 am, Gerd Bayer wrote:
> > On Sun, 2024-09-22 at 21:09 +0300, Leon Romanovsky wrote:

[removed backtrace and commit message]
>=20

> > >=20
> > > Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219292
> > > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > > ---
> > > Changelog:
> > > v2: Added missed bracket.
> > > ---
> > > =C2=A0=C2=A0kernel/dma/mapping.c | 6 +++++-
> > > =C2=A0=C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index b839683da0ba..bcb7a4aa8fa4 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -569,6 +569,10 @@ u64 dma_get_required_mask(struct device
> > > *dev)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (dma_alloc_direct(dev, ops))
> > > =C2=A0=C2=A0		return dma_direct_get_required_mask(dev);
> > > +
> > > +	if (use_dma_iommu(dev))
> > > +		return DMA_BIT_MASK(32);
> > > +
> > > =C2=A0=C2=A0	if (ops->get_required_mask)
> > > =C2=A0=C2=A0		return ops->get_required_mask(dev);
> > > =C2=A0=20
> > > @@ -926,7 +930,7 @@ bool dma_addressing_limited(struct device
> > > *dev)
> > > =C2=A0=C2=A0			 dma_get_required_mask(dev))
> > > =C2=A0=C2=A0		return true;
> > > =C2=A0=20
> > > -	if (unlikely(ops))
> > > +	if (unlikely(ops) || use_dma_iommu(dev))
> > > =C2=A0=C2=A0		return false;
> > > =C2=A0=C2=A0	return !dma_direct_all_ram_mapped(dev);
> > > =C2=A0=C2=A0}
> >=20
> > Hi,
> >=20
> > sorry for being nosy on this one - and I have to applogize for not
> > following the original discussion.
> >=20
> > I'm just wondering, if it would not suffice to move the presence
> > check for "ops" before the call to dma_get_required_mask() and make
> > an early return in dma_addressing_limited()?
>=20
> No, because then it may give the wrong answer for ops which do
> implement dma_get_required_mask to express a limitation.

Oops, I see. IIUC, it's DMA-direct that could express a limitation w/o
any (indirect) ops - and that would be cut short with my early return.

Thanks again,
Gerd

> Thanks,
> Robin.

