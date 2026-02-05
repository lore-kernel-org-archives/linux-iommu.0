Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E329C339
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305012; cv=none; b=Sf56Ky/w4Jw1S203OpuQvpCG3Z9/7odGN06yd61vqFURQ136tHHhO3EbScFRUHrlGODBsn1BXIJHjORYqSU1e+ESvPY48wtPdGSlHQzgOXV0iy2btn0k1BMyr78iRKfA78/G0la/P2Pxbb5FcMzZS5pkcuebRpDhP4nl5ZNAJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305012; c=relaxed/simple;
	bh=1/cZNAj5yVrTCSLan/Iqun1mttjNmbzyrzk36Gn+f7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGRryq4EsB9JiJcAEGoV/4x/V0VJFmWWAAYa3wFsv4OpQBY0543FnDbG+DRPw/0bcRjTB/g2IZvW454xPe0IlLW+YJrlnGtsT9ccqhKdr3mezsFTbTM0hdt9KR2BOE8Ub0U6Qazpk74BeoT+cgyZQ6251SdfFJ+Vdt9hZhF3GHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkqoqxYn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T5lfQL2V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkqoqxYn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5lfQL2V"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615EOMOg4126357
	for <iommu@lists.linux.dev>; Thu, 5 Feb 2026 15:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=; b=CkqoqxYnzOKs9q68
	XFI21yuj+oAFgjbA/X/FNlLGJvtgK8pyCgByoxx+snhxd/mhLWdakQ9+pyc42IWG
	L0zqO3thCvDBTHFtItuCgIbM9OYXlviCfVZZrfMDPotRHWoGOHqLAamu5+hqQU7e
	dMZhruqtC2vyJuz6DPlHAs2DOScm6BcI9wMp4f680ixIfRnG+hj50FclHjgw1arU
	Ax+e2qdRqlxStdL9+5QqU6zulS705p9yB6iY4BmocLizXQHM5IF+f1FVBLxc3xCF
	AtUsKW9dNMhrdFoKFriAuRsSbpnpDu/IfCoatDy4NkZ1z+fSOBCydpQEuq75l9ia
	CFzWgg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4vxhr65x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 15:23:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b74766fae7so969272eec.0
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770305010; x=1770909810; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=;
        b=T5lfQL2VvlD8xFgXEakBjOVyz/DKMcjWIrr30rDvi2GjEuWLxvYIJ0CJkTGGZDfVlv
         +qnGoMj2a/z7q6+DARAhpyXUyvH1Rm4l0mXj2uKHvgQKPFFC7038ohs1dGW0+3gGQYP8
         hE9gJlktep3Ybvt1ddcjV96bLmXffXpZ5mzGGyJ+43oh9CXYa/mWHqXTSR00Nvw13lRw
         bcEMvz8R9kvzg85s6H/PgbHk0Xh0KMPVfGBXc+eciECYUUo4BvT7tvCw56K4uUHbhh41
         4mulP0L9pbhth6RETI6wPRsBOmhxDNk0gTHCzKZUUfyw0TgTsC+L1YHBJg591VVjYYPP
         LrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770305010; x=1770909810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo5EChFJxxbLb85YiCCw15lKmFakF/DE4q1kK+Qroqs=;
        b=wRGYVnEVGFcMnHIdJafUIHsjjGBAILnxnkUkV38QCgG/8NE+RFS1TCuWEAGoCDUmlY
         DKCPpqqJeeJggafgTsa/oBM8HtNrgzYtJwCN4YWEY/2d0Fux+pqqXZ43r2I38H/mps8Y
         Zvc4X8bGFoCoNVqG+v58yML4MZZmleb+QFuQPwZW+tHu5GjHTrLpC9luRjgN4MFia3yf
         Sjt2VteX1emZP/cp+SJjQqVjnpKteyaCa3eL4ACreeix6ZC/U6d1sdIxZlRAUA/fydTm
         oam2wsvcYolFE0qLMd1Fx/tfBj2XNEmsg16ZRAYYNuVkLSkbittRG9Neg8+G27bY5opI
         ObpA==
X-Forwarded-Encrypted: i=1; AJvYcCUJqgl7sZ9XBe6SFQ1FjAXdSMC3UGk9xSPfAgtTcTvR2lAdquTBXSx8vxU3jQI3+3YdBml9kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVd59l30CDYP7ufdWV9VTP+JNYvgpPPC+zkyMY3yh/OS+VJbB6
	wt6CVMM5A9U2q7T06qksY+cCwc5D6Dbi+j+ZghjiR42a8JnMj3pDMT1EojClL7i0cEB8RaicECD
	GfSnYuY9PM7sQvHid0P93viGBkfjvG3KRnhKikC4tAkeVQ1uK2ybXBc/rRw==
X-Gm-Gg: AZuq6aIYbLeqyn+0rmNquLXy9+Ccx6bTsjOSo0X9avkwPWogfkEuR96JWEJN3tQfnAe
	/Eojw0kCtHg8LG5en4J80AMxvsVTS48dnoIcmBVnOOZJSHLjCIJ+nvb2yOIVEOw1pbNYdtMNYZi
	czhDOXdDvyNlbi6nd6dKR5nVls7biSB/vV7zy+70FacfBtRtLEktaGY/y9qnjhEDh/tS9OUvLGQ
	5a/aZfF5jGq9wobeweMTl/2MmCqGhERFOAjaVbyEsSewnuUVO/bYDS7hH0cPEbwJth04/hzJMdp
	gsf1Sk8x0ouC1Lr34Rbc841CBhuUHPFjLDbd6/hRGUELs2FMwIvrsL8g4q1XoPsQC8o1xbgc7B3
	Q9g13rYPQa8C+5pL2TtM=
X-Received: by 2002:a05:7301:4b03:b0:2b8:1d16:9716 with SMTP id 5a478bee46e88-2b8329e5c13mr2779578eec.20.1770305010045;
        Thu, 05 Feb 2026 07:23:30 -0800 (PST)
X-Received: by 2002:a05:7301:4b03:b0:2b8:1d16:9716 with SMTP id 5a478bee46e88-2b8329e5c13mr2779535eec.20.1770305007985;
        Thu, 05 Feb 2026 07:23:27 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm4844489c88.7.2026.02.05.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:23:27 -0800 (PST)
Date: Thu, 5 Feb 2026 09:23:26 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Zong Li <zong.li@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=6984b5f3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=lv0vYI88AAAA:8
 a=yG5aaNEj0tElPYM3_UYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=oJz5jJLG1JtSoe7EL652:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-GUID: gzj8gH3SwacLu3kJJF--a22fTzdU6F-d
X-Proofpoint-ORIG-GUID: gzj8gH3SwacLu3kJJF--a22fTzdU6F-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX27kl4BIV+xvS
 FIiWNfZLcxc8lCMRUxRXny1k37t56YeTn3eiOvsOFncWsQvqPLVZ3PdMY1bJi1V+/s13sGTRFt2
 Hn+I8AXCaVYnD8En8r3mZtt2d2bEwD1CouUk30esyfix18L56NBJ9emnbsvJoKRn9rW9CFkGrj0
 jK5x5264sMEE0x5dr3zOuvoYHzqpdDDtc3sgV1ANeWS9MRs+D2D845KRm/NX4CKvi9mN4G6qiXU
 VRmuxdcB+nCByWTkJQbSEAxb29dyVm/1CCYO6/LUS5C91CG1bCinooJqx2T+g6VWKFH9WEB3k0Z
 +zeSjPyKHXUyLDxglsPjHkehsnhqhC6Yi2He3+YgkY2ihc2F/m95ovCQAwmf3oVwJcNp73M/ljz
 Z708T6pGkHEhnt8J3KjhMP4SlABXilF3JKM7Gaomedr8DKRsn4M/+9p0uRXHWXsUInbHrVd7zFr
 Fcwem78hwkh2D7IKVKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050116

On Thu, Feb 05, 2026 at 02:11:48PM +0800, Lv Zheng wrote:
> On 2/5/2026 11:47 AM, Zong Li wrote:
> > On Thu, Feb 5, 2026 at 11:35 AM Lv Zheng <lv.zheng@linux.spacemit.com> wrote:
> > > 
> > > On 2/5/2026 2:39 AM, Andrew Jones wrote:
> > > > How does this relate to
> > > > 
> > > > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> > > > 
> > > >   From a quick skim it looks like there's plenty of overlap.
> > > 
> > > We developed the driver in 2024 and demonstrated it in China summit. We
> > > didn't notice that a patch is on-going now in the community.
> > > 
> > > Now it looks our approach solved more issues, and we'll check and update
> > > if there are any community concerns still not addressed in this patchset.
> > > 
> > > We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
> > > patch if he wishes.
> > > 
> > > Thanks,
> > > Lv
> > > 
> > 
> > Perhaps I can first post my next revision to the mailing list (hope it
> > won't waste the community resource), so that you could have a chance
> > to review it and see whether that version is architecturally closer to
> > what the community is looking for, while also addressing your issue.
> > If you also feel that my next revision meets your needs, perhaps you
> > could append your additional implementations on top of it.
> > 
> 
> It seems we all composed the RISC-V iommu HPM support by referencing
> drivers/perf/arm_smmuv3_pmu.
> 
> Robin's comments should all be addressed IMHO.
> 
> > Of course, if the community would prefer to go your version, I’m
> > perfectly fine with that as well.
> 
> OK. If we send a next version, we will add your SOB and please help to
> review and test.

Zong Li's SOB should only be on the patches he authored. Don't put
anybody's SOB on patches they haven't been involved in. See
Documentation/process/submitting-patches.rst
"""
The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.
"""

Since Zong Li's patches were already on the list then your series should
at least discuss them in the cover letter, explaining why you've opted
not to adopt them. But, most likely some of the patches can be adopted,
so those should be extracted from Zong Li's work (with authorship
preserved) and based upon in order to respect that prior work.

Thanks,
drew
