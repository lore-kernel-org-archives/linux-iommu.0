Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D51D63E4
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555905; cv=none; b=G7iM0NKwCovH8BSEAs2sl9BWYud4LUnJ0K4eehV5imyYFjiYvDR4eUEeV2lgX2uLGP1oZD74qoVwYfXRJaPOcudVOCY2foe/cme3SefIP1Zjc6rjpTr4N9aP5WYLd32PN4CJ5SEYMw5TaAZPouzg+luzEzuTtegD1YAN7wmsdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555905; c=relaxed/simple;
	bh=phjjPfFHyzFAWq5CyCS+9yYDMFcFn06l5+l63zWy4+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2En3DJ26tbtxZG3DXKXfJdQuhOYtSTNtCjhaXxpeQAdATbvwsN2hqFNzIyzXKvqh9UxOCHDH21ysHTLTIw8Amurb/NoEjZCbEws75rLkM84OGnfsPWJPwpm7l7I/IatThpBFY/L3uBBfjZ8YhM8cC7hQ0xiRfSarMilMHDIhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NKB6rvrL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NKB6rvrL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VkZY856974;
	Mon, 24 Aug 2026 07:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rDUwSADGQ3+3/9pwWzu3AECRugdjK0
	pMiJcp6a4ybSE=; b=NKB6rvrLjgYMXSOupehlwRbFTQPJO9vnuaI2lOKUGgj0qQ
	b5Wi+8RMtiWFWpjRKFJL6j9yJ2i9AqVTtSZZwm7uJFf38GJ8LjU0BHeMwfD8clVj
	stq7Xy8z4KrRso2eFBvv7y0/QrCiv7hwoYr9/Flc8HVmywYT7LixkqtmVciwuA9u
	uvJIqZBGBr0NQQZjO5SDkxIP8Z4o6ngGHQxNw4cZH9mWbNQ5atX+aJ7dlCRrL3vj
	8k8xUoYy4SKNbOoLPB1geDAummZOsn1N2sVP2oGw+Mh3+luaUEBtu6CajLXFTibX
	Y8WiX72qSQpYoakYzPPN3XzBeBw7a3vhGU8KYg9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hg133-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:18:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O7BN1v004524;
	Mon, 24 Aug 2026 07:18:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag4cmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:18:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O7IBOS43581780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 07:18:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A73C520043;
	Mon, 24 Aug 2026 07:18:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D2C20040;
	Mon, 24 Aug 2026 07:18:11 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 07:18:10 +0000 (GMT)
Date: Mon, 24 Aug 2026 09:18:09 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Message-ID: <ttk9iy9@ub.hpns>
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
 <ttk8qcx@ub.hpns>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ttk8qcx@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfXy/NRhGM6+/Bw
 /xQiWAPy+qAI3QwYEp4K5/8Mg6Cp+ek7ajIElGA7BjQaQhtZyZP5SAb59356n3r7288XBXaNUt+
 SOUuZW4jD0568USk9GFMyKh/UwhR/UM=
X-Proofpoint-GUID: SCyeP6TYNAgiGsNIQAvObR_cZwpozMrl
X-Proofpoint-ORIG-GUID: SCyeP6TYNAgiGsNIQAvObR_cZwpozMrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX2V2iwNR5iRcA
 rNM8FmD3S/nVA5dAfZUTHjQ2KiXUc0yb1z096zgmyRKdYNUAWGdcBt6wuGWBiE1hvG3fRkBykN/
 djsjby6zM1aKlVjYDN3a+/RigwP+kWPxYUMKQdUiDI/fHEYFC+2N0Il9VNgUPD4X/wLeQatymKV
 H00npXXvlgtkaseVSldmGgDNxX3OLX9iYCmHcJl8/TZ0igw5X7u1FQLQVj++V3cnOCgqnJyOyOn
 2C7m4iJeFnSoxkSZacj95Eqd91xTKxwZKYkp2A7o4plmtP4+9MBSQpPRa1ufSAZGmzmUhIC74wn
 kvY8Z/KumCfRzY9Mc5W1fhSOMJy8YdT4woQPqr1WCoXycyyVjA1RUqEBqKJ1zVFxEenlDET9hH0
 hOywP1MxI9P5iRNZbNKX9RJtSTExDjSf8GSKtRNnlESe+K9lNZ7w2cx186mJgl2gPFy1uOFq770
 0U0EGz5vyAnAolBBKTQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8bf038 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fAb0ljxzqltU4ZU6W0sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240060

On Sun, Aug 23, 2026 at 11:00:33PM +0200, Vasily Gorbik wrote:
> On Tue, Aug 18, 2026 at 09:13:17PM +0200, Niklas Schnelle wrote:
> > When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX
> > get_rso_from_iova() returns NULL when the region-first entry is invalid.
> > Yet in get_rto_from_iova() the region-second origin rso is not checked
> > to be non-NULL before accessing rso[rsx] leading to a NULL pointer
> > dereference instead of a NULL return when iova_to_phys() is called on
> > a unmapped IOVA. Fix this by adding the missing NULL check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/iommu/s390-iommu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied, thank you!

Oh, I was too eager here. Please disregard my previous "Applied" message.
This usually goes via IOMMU subsystem tree and not s390 tree.

Joerg, Will, I'll leave this one to you. Sorry for the confusion.
