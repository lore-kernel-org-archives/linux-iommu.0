Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91D28469F
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390587; cv=none; b=HkA85/KMWVm7B1XLGfTL3hlVB9h1OREwv02cckTU9LczOolF4ZkDfhmo/Rd33zZeS+IGPQXNBMauiWaR3f5ri8196ypVXljE7Iz9akArdwl2qsZCMcCijn+BrnIHKXcjo+iiVWpdCLCDGqBwbyrc45ZuWRO3NT8rRchE9ZwKng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390587; c=relaxed/simple;
	bh=rdx3OV+nUN93GHAqETEZwEgh+ENPZq3ETzFi6DimpXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElXwVpTn9psi8sDQFGvwhU4UQPJ7NZgGhSpnf4GWRdd6ipOtBFF1QIJJestfqkwcpVKnZAw5Vq8xW9s8ZV5KqLMv2/lNdNr8zwTGwbSuePSJmYLWv4dU5PF03YUax2m2HDBEPYcJJDkcy78/MCya71MF5dSIuPtlNmyfYZPWDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6AkNa4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dhVehnMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6AkNa4t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhVehnMY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6169QQrd2228092
	for <iommu@lists.linux.dev>; Fri, 6 Feb 2026 15:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=; b=Q6AkNa4tpF7NF+Z9
	LNSqfgkRZ5EHCySJQM+l+BsFwhdrdsUmh/9hTV1//IYJtkaHrqUvqt9Hk0INRxY9
	VVybfsKO/IzvtX/wgIGb5XSQkkOqsvBUqcmtSAj2kDDpLlLc3LXPP5L/atB2zd1a
	285+qX8bbUy7dTqos0lGzWF7wP0L3tWgxtlk4IWXehSX3/ORgD0nf7MREHbhfjln
	aQHKvb1eHaEcKdlYvpBncBWK1iOwtA/eQoHyjRrgdRP5bXMgvyTjCMsIdmfFqQN5
	HsjxgQv1b/PuvLQZbdJRTSsgFrrfIrxUrLISjKo1CM2uDDf/c5W9QvS/GVK/YBI6
	djLgpg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5dnygy4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 15:09:45 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d18673d47aso6802231a34.2
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770390585; x=1770995385; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=;
        b=dhVehnMYFhV//A/2JRvrycwWNjAdOCv4WkeWzvmE4+sPrAAELrbejwZtTfrs0Vu/GX
         Sc2AJLSfJXwrgc+SnSjQigABFEnlekjz0Dcy+y/69KMNNoRg3BYUlA+gVbOKEIYQqkMj
         BHs8T7nG3CyY5KRKeIP6bWa9aJkluZWAH7G3dGXEoLZMbB77/34P6S4FRM8ydk1hKckR
         wvfkwC3fq0uZKUN9ZU5qOgsBOhL/KZH9BvU5lbsnrn1Dukgnoa57PkhVzjr/FgL45F9r
         ekjbv4FhJupaWTEO9awuxxE4/XX1NtNkc+9JFNohHFogI7H6jJhD2yk9DgtcFdcxlty7
         4F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390585; x=1770995385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=;
        b=Hyqh6+HuILHyVUxUHe4YJi3+Xu4+NRTB4dQlpGAvX/Vp1L/r/JghYvdbx1+R2sQXgQ
         UoaMXyVXL0jjJmyqKDnvaPcgutc4RBhVQ+m2VxIilNUFUHI01rG/VTDk1/MHOxCEdh9P
         DlaNR3/IE3DYxmqCVC96+YmBxekQppCsPIpqPoiDBS5ueTduZ5gPx6OcG3YixRLmZRhf
         Iyqgn3+cibPgYpa2Ju2EmGELSHpTD9KJ7HuGGDB5iU6dSTyPJjDwbXUV6uoFj/RsY3Qt
         msldOrUocTiuo+m9h1cpCWsLlwhdJ14zTQw6sysLsRgXaePtTRWzVvXROEm6VBFIVqhl
         AbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mhLgkeZ5mZiye0YMEi6peUVb7BoMTcG36zkhBO5aP74Y95iHvgPx/RnM8U4FkfUEO11oDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKgNfaf9YPG9ptTIucWprZ+DgQKZZExM9FIZHYCMyWymhveBqm
	O/sQ40qWPlzqBQQa3PQPeNBPw2g2KktVVUnbPEHbq48bP4SVInqttMnI0sGSFugdtfz/TYO2Wx/
	5bHQO/RFscuhvipW6T6lbT+ZcI2sJJExQKjrAImXHe0a6YM7Ok0QdhCqK+g==
X-Gm-Gg: AZuq6aLj8dbxNcJK5DXLzXok3e/vsdYfZCc8GNiW9uwf1HoDkjuVr5d4KgqdrK6A/1X
	Iyn/0C5wC+GRHYpGFy3fw4Ar1jRRq+CffgLW97RL5sGb8CGmPwYi5NSt/LnFOtrSmbT7suYdRIv
	Zs1J+sa7SkYe3clnnOCV+i0SfZTbcE/+fEpde4re83zq1SWMe7HwdNnMoOxAl7SRoHA8TQhGVJm
	yF4MVuxM2CsgHp2c4KQoQjLz5nbNC0uh5tekPLz61IVYBQ7HSfYIhV38nf6Ia6e8rk61wvtEvLw
	6LvRFKz+zmcmzWT8wsIpLOhYYybUyfB6yX40kdFF4kMIt5vxVgcmvZ+As2HpapnYdsqhH8h6/eS
	57eFEzXEq7nobgfUJRZ8=
X-Received: by 2002:a05:6820:228a:b0:661:ae2:95fb with SMTP id 006d021491bc7-66d0d2faf29mr1460739eaf.75.1770390585134;
        Fri, 06 Feb 2026 07:09:45 -0800 (PST)
X-Received: by 2002:a05:6820:228a:b0:661:ae2:95fb with SMTP id 006d021491bc7-66d0d2faf29mr1460723eaf.75.1770390584637;
        Fri, 06 Feb 2026 07:09:44 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d391aeb93sm1202941eaf.8.2026.02.06.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:09:44 -0800 (PST)
Date: Fri, 6 Feb 2026 09:09:43 -0600
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
        devicetree@vger.kernel.org, Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
 <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
 <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com>
X-Proofpoint-GUID: OwsYoeZdWIWjdS8O9WgX7O26XCRMjohm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEwOSBTYWx0ZWRfX8tKanOxQIQOe
 S5CsYSIz6DzQgdquJBVQOebEZ6e7tf2bbPmcCom6Bm/3TCAyY9q5DoHXYg9k4w+fixEvuBNETlf
 tdquqjlwTwiVf2R9vdJSkpSrA11O+rcAVUT00d/PCOb0/AxNao9/BI6eiuWYxhEGqhC9V40OX/1
 RTV3EzAgropZfhVjJXhRAdW/z0DTljQ8sUmKQbhS6dC0MhqfuLgIAXeOVla8uOZhhUpT+6hXwlR
 wWy3pQE/FjPGcF7rQomRfl6wx3OHPkRQTwGFHD4Fa6Z0YdmepY9M7fxNNMrmszF2p8QRQGTfl5B
 U5dVwiQREj8/CrNpAo70QvQ+KZlRiylM89/Z5d7bWxfO1DPbEf2Nq4t/RPsS3MOfuFdE9qAJ8CB
 FxcqqvYTqG5A2QE4RmeqapW6imbLtIq8bFY+KvGVkok3hFgQ1b/bddn4WQ73U4+2m4wDJyX0kMf
 UenjBVA7utpKbSnRzHQ==
X-Authority-Analysis: v=2.4 cv=C73kCAP+ c=1 sm=1 tr=0 ts=69860439 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=pGLkceISAAAA:8 a=gObE7mBVTb-_oU6ProoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: OwsYoeZdWIWjdS8O9WgX7O26XCRMjohm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060109

On Fri, Feb 06, 2026 at 11:42:39AM +0800, Lv Zheng wrote:
> On 2/5/2026 11:23 PM, Andrew Jones wrote:
...
> > Since Zong Li's patches were already on the list then your serieswould> at
> least discuss them in the cover letter, explaining why you've opted
> > not to adopt them. But, most likely some of the patches can be adopted,
> > so those should be extracted from Zong Li's work (with authorship
> > preserved) and based upon in order to respect that prior work.
> > 
> 
> You can see we have contacted each other in community, and decided to
> cooperate in this way to honor his contribution. But final decision is
> left for the community to decide:
> 
> From Zong Li:
> >> Of course, if the community would prefer to go your version, I’m
> >> perfectly fine with that as well.
> 
> We respect all contributions, We'll add the link in cover letter to the
> follow-up revisions, let me know if anything else should be done to the
> new revisions.

Just do all the communication before posting, allowing that communication
to be summarized in the cover letter and in any appropriate commit
messages so reviewers know what's going on. Also don't forget to CC
anybody previously involved to ensure they have a chance to chime in.

> 
> --------------------------------------------------------------------
> 
> And let me describe in details to compare the functionalities and
> addressed comments between what is provided by Joey and by Zong:
> 
> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> 
> There is no missing functionalities between the two approaches, I also
> checked the original Robin's comments, let me describe them in details:

My concern wasn't whether or not Robin's comments were addressed in this
posting (that's important, but not what I'm talking about). My concern
was that Zong Li's work wasn't addressed in any way, so appeared to be
a chance for duplicated efforts. Indeed his reply [1] indicates exactly
that and even that there is a third patch series being worked
independently. Please work out who and what patches are going to be
the focus going forward and describe that decision in the cover letter
for the next revision. And please don't forget to CC Zong Li and Yaxing
Guo.

[1] https://lore.kernel.org/all/CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRjW2fXHYrjHA@mail.gmail.com/

Thanks,
drew
