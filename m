Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992542;
	b=QAGlPFeibeOaQ+DVIv9NeGAgveNJJecCkZDHeqOG4TPtpFeMtEDKrbJL34QGVQC7JccC
	 ciQcllKAfUyBza0wV57ClopfTy6+7EbxpLah2cLwZwV0MtbYLz8vOBjBSZPmE18nwyrrV
	 TlIEHbiV9nVU5bre+xcIXVITxWhi6uhfbxKeW0q9ejbV9CScXMPBGItCrDr8XkQ2dxFmL
	 mZOowG4xfiTvEWm7NsXKn6+bIS7b3IOvr447I7oRKLD41p415IyUsqil4wQDk51fykxx4
	 nwmNMLXD3CYtquG7YijOKfyEESfGo25l7oQYHOMpHg51AcFRD7I2IirSzPFkSDbMLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
	b=XJJoc3X6HW+++kQNVkoqtpoPT+nX66fMpBvhdmDT6EgIRWUkINWGQs0yP3dK23l3n70Q
	 ULIpYky/ncXinB00DDDLrgIvgagZfV69unZqu193bbbQ8++MAkHTM2+folGaKlBSJxiCU
	 ty9T7oXC7kcUypNcNCM5Btc7IZdbeM0jNse577YghNM0MKuOTEQNZ6Oy3nhmhDpLM1lQ1
	 KkD0hPqYrHB3TNj3eEVP+nd+hDkUUf/PLIeOIkrnPTG/9+rPMVNsAa4VA+zyCSzXptMxK
	 PCuDsLgHpBzMH1rRgzpzA0V9ChyvltYKMHPAvtIh8AYkykPEAU8bPh+/1i/1mni4+8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Fa/9Iryi";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmWF5Ef3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F14606A31C
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 09:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fa/9Iryi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmWF5Ef3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8PcTk764130
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 09:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yyZLaNLsFBfc0JqArcrGxcWE
	FwZyPv7YYEvEtfwd+rk=; b=Fa/9IryizRttAHlUczN/6wai6NYxknNzBYBuBmRe
	NDt4VFh45iJ7hI+MPeJ4R2GM9riVStt4nxDR4y7MF60N1Ilg1hozREdZGUO/fea6
	FRVcg/9sS6c4ubwFp60b1dTvcV7OO09I89EJoCIRlrBZ0+ZFgUyV9SbuDmcZSYYo
	rzmubtC6D0DlMC9+7Ql+yf8bUi8vhMzgK4fl0sJ+nkqlv4xYprIv+z6ZrM0V9DBK
	mP4Pr19Ez5j2LwV4H58BGr/7PMfNz48w1KDCre8iWrNi1C0KtSXiJOvjs05senUV
	px8XfQEY9nsOAUQGfpxynRuWxEeFTTKo2d33wfGYtWyGxA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvba743-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 09:02:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so184994885a.2
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794992539; x=1795597339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=FmWF5Ef3TtD8B+dNRYz4Y5wXptQUEMIack8J3Z4OktF9B9SK/I56CZkl+DcC1oAtVm
         Zq/gBSuLA9JyRP4erxbCZR6XcfFmU0n5vmBtPrruDSVkOyUMf97JZ7p6BTAqmlGBSqkH
         TNflglU6j1F3PBgozpGz4XQavW5/r9jT3Z6fJbbD8MWPAWsF++cj7RHyV5RJnuvEJlnd
         +gvi8A6LzN3kzxkpfw6JExmHEUTPyc9ISUg00gck7lOE/oJkHOLik7cDnYbvu5eVBn2W
         Gk2Y/+z4fGOLjvWiMMDS1byPgsMGSF6C/h/TQcJCk8xMnJxjykMTl7hI/qXj2Etxi6Bx
         UzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992539; x=1795597339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=CLptaBX9Jd+KiBTYe5cMFqEGUwtEf72386FOWh2c1BkRTgmxhB6kIHwJNrcjZ36sqs
         DpUPgXo1qqZUyWTnNSL8cV80U+MFQg3jqcLQ/YtnvlOOXha8wwVfet0td4uT6E5n0xYq
         FgECPQkISqepdMqOxsibR+zT8vHhwRVQLzme3Un8c6H688a66R9v4eTfXORm6EYWOIiI
         4FzhFFeDnmcVuPlOGlMZZ7xFi8wVrBswRY30O+nQb0mez2iSj1yKk2PiAhknTE0Hq3Bk
         hOsYH9ncZyZmNkI7PCPN1++AAzr5BhYl0wKUMpS7DO4Fs2HHzdaz2OaJfGxLALtObiEd
         FPTQ==
X-Forwarded-Encrypted: i=1; AL+hErH7bY6D9kOg+ig8427fvy8W3Dq/hnOUbHOz6VmOGJytx6IGA1o9AvkyTNE5YkDNp3IDVurR6w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/roangNiQswU7xGknSwviHPWznT2Cwi66KkLDJfWi3G422dpPA
	zkWFFLbTrVmkCF7nL/BzT37rJkYQNL8hezDP9GKGqjH79XZ/7r9u/w1q+p46EZzKLAQiUzVD22V
	mwnWLtbvBILZr0WxoWQypp6kC5fTUk0C/4HMVXQ85PTTWVHyUwe9qbeOOVA==
X-Gm-Gg: AYBFou0aF+XVX9RYoQ+22eFR6tGCcQWbqXp2O2NCeaWO97Zh5WZARr28Uqyw48V/p9v
	EEWkC16uIACMTPCj6+j2qV2GhuN95whXITmBMEAHsWwcJ2n7xaq6xTIWGiJyVLGM/UuI+OEbfB3
	5O6jcfbZy+dXrGlepIM7IHD4Oc4IA0idfB5UfcB+lScleVtGhQTDRJLnKTnMVS6Uk9d0ymPn5L9
	JX4GSiG6mIXtqnUwuF7N7DWFi8QdIR44SqaJxq/gbTI7LvGxgdPuGPsL+OGo13tIPlshFUESfKm
	58up1PhdYVJVOg8KnkuTBPF2ZFfRagzT3y6GdUq7bI0lk65DAuV0l5YhmXSOU31GD6fDoAFaV/Y
	/AfBGpDZOGE1lOMcNI6wWZHd29Df5HURuuZ99c2Lu5uxbF1j0tN1Jb+NllSR5fgzram1MDgJjoC
	d7qSXQCfD9WNJCXhHFnbkYfAGx/5+ogwZv2018QD7IwDS2XaFGBO+m7KmA1521yw==
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377682785a.14.1794992539368;
        Wed, 18 Nov 2026 01:02:19 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377675585a.14.1794992538630;
        Wed, 18 Nov 2026 01:02:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae67b429d7sm4551491fa.36.2026.11.18.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:02:16 -0800 (PST)
Date: Wed, 18 Nov 2026 11:02:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Message-ID: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
X-Proofpoint-GUID: i3qHAUIv-IfCcaSS5GXJyqUpae6TbFBo
X-Proofpoint-ORIG-GUID: i3qHAUIv-IfCcaSS5GXJyqUpae6TbFBo
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afd699c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ypECYpogRKzTefqxK8cA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXzAvJYSdbO118
 O2/YwaEhTgxiBvgVJcCU5v35AA+1LhdPdzYt4y85Nq1C5aA9niX+B/5zvFs8fqZhVgKBkZU5X4i
 h1eOAnwyl7qaAZ8iSHxyosaPmUnQY3M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfX+7CqvDomsFHI
 t1mMxld7pGf+oCruiNwEa/OQBl55artfs2mK3cBldmpUDz4T08Bdb+eQ2SkINOwdAD5DgVvaM4o
 hhAwJgpgspMIyp7YDgER4MeZU3aN4QaR/Mtaiqr8Xh8ChC+vf+RYMWftmm+sbNsEI6mbQy+UlPt
 GiJ2Y9jW05napx2xsaEe3KGXY7pjIsbp1pJ1yR5oTGGt079QXY5dT1cvnm1cwFl0N96tfNWCn6H
 2tCTcO8IQ8fnX8VBnhBfdIncopf7YjXugaDJnjs2KjT2fuTyDLKphuebG5fzDII/Xj79QyBvWoQ
 suN6EdociHl0J6Sn3do7PM5LC6js6xk9aL1LI//UIg42hLvDb/m/sCUd0jYHhJdQJQGI1dDXCbY
 z9xdu9K3FO8bEP+xoNH2ZAZRyzYDR8XMt4bOgK7wTI8QnNbGFFGA8xSVZmJjob9zAuAbCH0j+2Q
 UWiCHHGi+k9RxZxys6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180035

On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
> 
> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> > > The OF_IOMMU code relies on OF address parsing helpers, but the
> > > dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> > > of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> > > annotation to handle configurations where OF_ADDRESS is disabled.
> > > 
> > > Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> > > preprocessor guards and __maybe_unused annotation.
> > 
> > Why? What's the problem that you are solving? Why is the current code
> > bad?
> > 
> 
> The commit describes the problem as "The OF_IOMMU code relies on OF address
> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
> Kconfig"...and instead the code had checks for config or __maybe_unused for
> cases like sparc.

What is wrong with this approach? What is the problem? There is one, but
please state it in the commit message. Something is wrong, otherwise you
wouldn't be fixing it.

> 
> It was discussed in prior rev
> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

That's fine, but the reason must be capturedd

> 
> Regards,
> Vikash
> > > 
> > > The only architecture supporting OF without OF_ADDRESS is SPARC, which
> > > does not use OF_IOMMU, so no functional change is intended.
> > > 
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   drivers/iommu/Kconfig    | 2 +-
> > >   drivers/iommu/of_iommu.c | 4 +---
> > >   2 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > 
> 

-- 
With best wishes
Dmitry
