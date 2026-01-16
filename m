Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CD2E11C7
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598645; cv=none; b=WgjLalGQjPRabJtPA1u65nUO0HeObSaA2pAUz8pzi8yHiJBz/AVDzIZvbE0u6TsLEt0FsKTEr3sO1Z4/GgGqsEwe8m2ROaKAs159IMiiB0dOLuYRp5lsTD6Hrax7a3DWf9b0SGZNtRc9V5jA8oIM5/xuizXluOgr5dt//gtuIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598645; c=relaxed/simple;
	bh=hSqbHzGoEdq4dqv4KEPscs+T7nLekPj50eMhSFDbcsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9mewCl3tOyXOkQI0ldO+Ss9tqwjMHgFDtPLtbfzFXrolnBcPOIVBCSG7r1nQQLjRGnb06V807v5dTDlgF4kWZgPyehYyRfcpu4P5eZ1Yl86cLnUHKhhGlH5T2fKuLTrE+huznla2Ru3J5wdiG8GiXoLXUCTqLLGnc9xOpoKyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FsSj0Bn6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PUN5S9uc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsSj0Bn6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PUN5S9uc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GKUr6I2484706
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 21:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2kQjyukwQsEZz7eJesbt8Fp0
	WfAJ9PDqixd1HJ4Dke0=; b=FsSj0Bn6PrEUY1q8oHpE0X4Yt4Yo+PiNn+MFljkj
	rGQ6yZXxp7x3MuOZqZGOwMEvrTQAmQkev4S8NoNwPmPcHPqwx0Ef4WI7e7XQBO4E
	iCofQfvatjltAI0wzGpQ+U+U6QV75ctYstEisG0PPzXp3ojZvgqvwvkcRiQArL8w
	4FiidZbiynIa4ZuVbiir+dp/eGbWwI88G6oSOLcnWnaciRlOT/W9iOE/bmgF/cc8
	SQC3bBGSACmoAAKnU2GL+LWOYxY2RrLEp9NJ/UDYYKkp8KNbD0APYCI7FuZTeZAt
	+ZdkpqTgvRlaIr+2F9PYAtlrCSZW7rsGUyqz7aYQLZt5Lw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqvecr4qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 21:24:03 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45c882e2217so3491241b6e.0
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768598643; x=1769203443; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kQjyukwQsEZz7eJesbt8Fp0WfAJ9PDqixd1HJ4Dke0=;
        b=PUN5S9ucQjMFlE0VX18vMFfQhzdN0yaCOonCQ06rvAqOxxFqowbYWD2VkXw1Tg3OgS
         FGkX8nbqLjwjjQto8i5ksQJjjlE5/EO7QaOaSTrCgOj0uH6GxmtXXrduqZ2qgGGmueD7
         yMTMpVUywu+Sj6bpYSmJwdKntvZAjdz4ZEz1g+WD+FIMbM3N0Tvif/iNYuQ/aBxaE6sq
         zeS3pLH/x4sD3L0lowCcvGiOWWnG1cNTzUJgzy4uaYpZqfP5JB6iMCBETlW7liYM0Rpg
         87GUaxgtTVFv2cQWjzYBn2c4m4MiP4B5Q4bJl4ac4Ce3lSwiaavDLMVGPU2D+vqRxyRW
         zeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598643; x=1769203443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kQjyukwQsEZz7eJesbt8Fp0WfAJ9PDqixd1HJ4Dke0=;
        b=Gd/jmWDKQLVb1ML76kJIkmMknHfR2gOBAX6JLmCB3Zlpn1qlVPKmqeXFzXM2o4U3QX
         Wm7Z7zyg/hmCcaiV+l6bLqcfW1lspZe7LcyaCC9Mv1EJR3d+FNRlBg4hrt03zYUaJ0po
         KDksl8CiLj9WOchw/iHHNQxgqSo2JMecYplNYh3/Y/+1KfyyLCViGIaN27XXyZ3Qqu3g
         Jkkk6FJ0rz3zGtDD0mWSVr5+Wt+lK+zVni/m9MVb5aBUNn4IEi6ghqOqBinrkT9ZSmfG
         llaoVFPQUlcTIfGzwIVbFaEO2j5+tNeKT29W0w6+X6g/Us/RBZtkx+a3ufk/qrs5OEbR
         AFjg==
X-Forwarded-Encrypted: i=1; AJvYcCWi6fRFz1FmF9DeChZaEi6dQ6yqqJP2qpEdnNQ1VPye1KpLXRnHWMMBKcWVW7eSpQeF90+Q5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSjx8jlKBeFWeH4BFyFsvlY0r/evdALa+LWDnFS6niw2ylsE/1
	xx2bW2TJXkd/FtaCb57hp4MRyXZKEqam1w/uZ8OOu1zPUF5NeHpWqtoE3AQ5wbV/jNTQtSfI8yI
	a/oTxZSBc6LlC5pyCPcDJ6nZDtR+dn4jsg+MebExTs4qXpBvyQsnjLWg8zQ==
X-Gm-Gg: AY/fxX5xwWCPt4QhjTOqvCN8jEkqvB5JiP+zpPuOfd+fpgYctfQwwtmeMOIoGF02tqe
	ktzoSMjfpdDaIgMAchEf81nhHzqg7P6DZjKKreyp606kvnwl9GMOIukyYgQzvxYlH7mUC0wpUdh
	g7pwNSfII1qBPS+uxaF3LOx0c0YuKVksdL251NBxmautmCreiEwujfJbuZpOp+G8xuwTRgeEN/I
	QqFE37ekK03KrDEH+3SzmvjvQieIf/b63heINHBmvTN2+4RHHhTO+uBwgZleQv3nX6zU+vS12Jz
	ihS3ag9atXyu+QWuou6h29luO9j4RIBEhyNDsfs/pAXdp2AVWIZy5dW9wm7ezTOCB/5YJMR4M2V
	P1yNnSdyn4pgz6ymw4pI=
X-Received: by 2002:a05:6808:5381:b0:450:c098:ad52 with SMTP id 5614622812f47-45c9d6f9b71mr1643550b6e.8.1768598637946;
        Fri, 16 Jan 2026 13:23:57 -0800 (PST)
X-Received: by 2002:a05:6808:5381:b0:450:c098:ad52 with SMTP id 5614622812f47-45c9d6f9b71mr1643542b6e.8.1768598637623;
        Fri, 16 Jan 2026 13:23:57 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9defa8a8sm1887962b6e.6.2026.01.16.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:23:57 -0800 (PST)
Date: Fri, 16 Jan 2026 15:23:56 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org,
        ajones@ventanamicro.com, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Message-ID: <q2jjixx6imiwdwlxiu4cnh6nghnueivjge5d4jscor5q6yx2el@lxujpebn3nsx>
References: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
 <c5sk7h5r5fozjdyguamekenlzd7pzbtvdh2boq3arynxifba22@ii4ikea2tuyq>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5sk7h5r5fozjdyguamekenlzd7pzbtvdh2boq3arynxifba22@ii4ikea2tuyq>
X-Proofpoint-GUID: B84i-jzOeHygtnGM-b5pIY1xA_3LuzjC
X-Proofpoint-ORIG-GUID: B84i-jzOeHygtnGM-b5pIY1xA_3LuzjC
X-Authority-Analysis: v=2.4 cv=L4YQguT8 c=1 sm=1 tr=0 ts=696aac73 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PgKVwnkvcHvZA5b4cyIA:9 a=CjuIK1q_8ugA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDE2MSBTYWx0ZWRfX5COG33Un4NYk
 EGuqOs/jHOHCbekCfyjKUJwoebFV8f5uqbYtCgYh8gA+zVsRhA29rx8ttuz5rY5X4LRBONCGRap
 LKnuijmF1yLDT9AFmvxhOkhWkZ8FiHH7+TGi3PHVvsaUDgtXwHL38Fc+ec19g3h0pvm2oxBbroQ
 tz2HJk+TXa7gKli4PFrCUMBMXKHz9BjY3eqCyG5xLPTkbCOmnUzawh2+2HmNTJDpFaAn/FAmPY9
 teMzKNMuZW9uv5pAbVwx7L5wWWURP6MNWPMKzjp/zfAw1ne8OIY3sAv7nJMeB86iVVN+muQLqt2
 /hZYobzMojiY2ioMye88PjyOx50ikFyqrIigU8DZavex5Dq16PflcqzCEvsiDYp2RrvVQGVj6fJ
 BZrS24ll5QZO3IkkTIflWEPqKLi6CyorMcTfSoGdvNi5/7SaVi4sQS2ZRnH0H86G3fZvzstuMlY
 7m689P0RuNXvnhaABvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601160161

On Fri, Jan 16, 2026 at 02:12:06PM -0600, Andrew Jones wrote:
...
> > @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> >  		/* Invalidate device context after update */
> >  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> >  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> > +		/*
> > +		 * For now, the SVA and PASID features have not yet been merged, the
> > +		 * default configuration is inval_pdt=false and pc=NULL.
> > +		 */
> > +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);

Shouldn't this iotinval come after the cmd-send below?

> >  		riscv_iommu_cmd_send(iommu, &cmd);
> >  	}
> >  
> > -- 
> > 2.50.1
> >

Thanks,
drew
