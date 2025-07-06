Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC320B7FE
	for <iommu@lists.linux.dev>; Sun,  6 Jul 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823810; cv=none; b=Bv4g5tW/5itkdaLZJE+JZ6Up5hBY+hZej+qLZQZKiaqpQwJ8P8j/8XxTDEk0eMhkuY5Zf5xBwBO4+T1DF1CxCIMq09Y9SjQGHJoJCNNBXK2FpTSaqGkS6y3LM54WFDH/vALLauMduK47yaNvebKaE4inTtWK2GjbJt4jdiUnfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823810; c=relaxed/simple;
	bh=dChJTGZn8G3JSF+xUlkCPdn9/tfQniGS7rIMUAbxqiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIsw/OpxJoevB3H4lJc8oIzjqmOf4Ntq2OCmg3/vkDQKKdUBS3+sTnq/XQdyJE3a5Ma/gMmUyJkzf5TkSFHI2wnKS1mrK2gCjwIk8BPnTu3dfI/Ksi8KmBMuf0TaJojgSTvYvb0NghcHltkr4c81OaRYZv411+7eUeyRlIRklUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=likQLbt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="likQLbt6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56660RSb031140
	for <iommu@lists.linux.dev>; Sun, 6 Jul 2025 17:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=LOX59rWqByosVSw0xaHgEnKypfzIaPx5HQ8Gnd0xkM4=; b=li
	kQLbt6c6JFl9/yDeu0PLNWkpj1eyrRI2PX8dpIt6o13ESNG6kDR5n/TrGkBAq0aa
	oWox/26OrYG0SMncLOX5FVSAYf9rFICArt+ure93zCgQMAy9NHZjkdLmsGTES30f
	nwpQkGZqtDCY6UtkfeWZ7lqg8Lc75TLgeu6EJBqUIgI2O/5KVfUz+Nmc/trADOP9
	uRFxxqvZVDyYsjDz3P4vfvkytM6qRuJy6YSxEEl8wpPMVwl5njIRrHBPP0DN3G74
	Yn5DMZyszkq9PGJXtKWCdG/wiqWMcEFpcV9TAJy62tJzH2UP8q6lSp5sSnhyeUJE
	04OCfiitXFztY1nOanYg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pveewfuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 17:22:42 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-40c65ffbc47so605864b6e.0
        for <iommu@lists.linux.dev>; Sun, 06 Jul 2025 10:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751822561; x=1752427361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOX59rWqByosVSw0xaHgEnKypfzIaPx5HQ8Gnd0xkM4=;
        b=BXpbCIbHAkTr+NHmqJ/P7UcmpzuGZPR6mlgcYJJlzIYISfhneA3/ST4kGoJ9/wpFE4
         5BZDWtnEcRNJqed96Ie0uOQTIZ5TAauCgk9sEhSECV/N4C5Q7G0RivzLPs+dbmcuUqcc
         +1C70wAGTls5f96ZcfLERVmrVx0BdJHDW2r/4vCdIwNfGbT6WBFWsHehp6xIrFdCE6wn
         jJCnRrH6QBa7Hj2euD46h1iIunr792EQ7AdzVjEelVDKFHdxs6PUSYfgwn59Css7krir
         ljVSbCW/XFWTOkmBURKcHDcSj6NtJ4lH7WPcdRXBDgvb5yJnEvbNWOSElioHrVTE0Z41
         VDtw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGPZvIabcv67zze0gUG2FZ7RxED3AihgQF2AJoAAyfZ0mWKQqLDjzTC6hxfl/Ujh9DSRufA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNwxiBdDjxromvKybIvj5NsJXd8hVviQ9QENAO7lxc00XLkngf
	+oCx9wQGCy8SkIHdkcSe1ga5NvU4ig+378LIVAu/IC+DHFtH7AO8hCr03Yv8ENNtyCHwlif1is7
	xhBT8GILsf4z6KwVhgZUYr67vg1raCCbUKGq0HlWb/DUkqcyock4Cy2xu9pxG+oNL2JfSJvV2su
	Q3ZIgwg+NLSiN3yW5opS2IxUy3IRklj/pv
X-Gm-Gg: ASbGncvhqMk/umZtQ+BJMTI3Ss3EYEsHqhLIl7HlV4Crfm8tbfJph85zXbnT6fTMzgK
	LmuklPwlQfCpWngtAoRqhnn9fdvy0VnE9x9VC64glM9gQQE7P93wmsEvYanK+BkE92N6noglYQr
	nSOZzsmRVkwLQhx0GniuMnSwUUwBofudhhlvc=
X-Received: by 2002:a05:6808:bc9:b0:40b:3816:6637 with SMTP id 5614622812f47-40d04430f90mr7183399b6e.24.1751822561161;
        Sun, 06 Jul 2025 10:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRx8YlZAXZI87WKI5wrFWMyyqOATVu6msOEMWXwTOG7myzreBVkUpyGxA8QIeqknVC/HOkS5l0RcGzJOGUVA8=
X-Received: by 2002:a05:6808:bc9:b0:40b:3816:6637 with SMTP id
 5614622812f47-40d04430f90mr7183385b6e.24.1751822560811; Sun, 06 Jul 2025
 10:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250705-iommu-fix-prr-v2-1-406fecc37cf8@oss.qualcomm.com>
 <c20a9713-6f8d-4c20-a031-dc448404d073@oss.qualcomm.com> <CACSVV02ioJfDyYLj6ASeQwH91n5CGcz+GW0wsupWJaUkJyFmqQ@mail.gmail.com>
 <CAO9ioeX0ffO8-v-mZaefFbyjOcCqGyu++gFjaMkpHPMyVOwE_Q@mail.gmail.com>
In-Reply-To: <CAO9ioeX0ffO8-v-mZaefFbyjOcCqGyu++gFjaMkpHPMyVOwE_Q@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 6 Jul 2025 10:22:30 -0700
X-Gm-Features: Ac12FXw9ekp3dldeCvMfuxN3qhkGwT6jmeHSunKw3NKlYFi5TZD1Bc0FmrK_Dgs
Message-ID: <CACSVV03JP-jRAJfB0NYNty=VZFVgrYPDkzkg27YYrgJBu1ymxA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: disable PRR on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Bibek Kumar Patro <quic_bibekkum@quicinc.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDExMSBTYWx0ZWRfXxF0gZzsD7BBO
 U42yppqwcdBPsD7yIfLN/JWs2GkzUFnD/4m5IRMER46TwBNVksIP52ZkBkbLv2Sk5YHCXrZ0nBE
 Q0hcQ0vzeRSMowNplzAjCPtz7rz3WiEN8ukmh5MDxbzxL7OjB6x9aNuAclmWHdnHIOdS/P/ORxj
 1O3ClAKO1DyfYyVeZWvYJfSShyruq92D/HUx/3NBCibURWj7B+kqdhc7aHjES1KzBy3MeTQdip9
 AWdyopksdLU0282uZg4LwgKMx3ByBoUnu6CJKXCC1styyhwxkpcQCWHeHYBCuzR4X/7WjtHWgUK
 J/b0k2xbD8QErrzqMCUqFH8qo5GT5hSuBSulJ4X3LVvxvVVzOmY+wuO4+TSAk0hDRbgTe57B+h5
 PG4HM/sbrwRiKX7Ersaf+zxRIYXZjeAJewxOvuWxeYWq4qLOT7NDdcnVbw2/w7gK8JAuB+bK
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686ab0e2 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=N1quPeXg1Wl-6W9anc4A:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: WQYoe_nlODbB0XDgQzyAOoHe-LsaZ73o
X-Proofpoint-ORIG-GUID: WQYoe_nlODbB0XDgQzyAOoHe-LsaZ73o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=671 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507060111

On Sun, Jul 6, 2025 at 9:38=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sun, 6 Jul 2025 at 18:20, Rob Clark <rob.clark@oss.qualcomm.com> wrote=
:
> >
> > On Sun, Jul 6, 2025 at 7:22=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qual=
comm.com> wrote:
> > >
> > > On 7/5/2025 9:38 PM, Dmitry Baryshkov wrote:
> > > > On SM8250 / QRB5165-RB5 using PRR bits resets the device, most like=
ly
> > > > because of the hyp limitations. Disable PRR support on that platfor=
m.
> > > >
> > > > Fixes: 7f2ef1bfc758 ("iommu/arm-smmu: Add support for PRR bit setup=
")
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >
> > > Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > >
> > > Unfortunately, there is no way to detect firmware support for PRR saf=
ely
> > > from KMD.
> >
> > I still am a bit curious about whether it is the ACLTR write that
> > trips the fw out (doubtful, since we write other bits in that reg
> > AFAICT) or the PRR_CFG_LADDR/UADDR write that does it.
>
> Indeed, write to ACTLR seems to go through, writes (or reads) to
> PRR_CFG_[LU]ADDR cause a reset.

ok, that is what I suspected.. I think if we can somehow figure out
what the inaccessible LADDR/UADDR values are, we can come up with a
reserved-region workaround

BR,
-R

> > In the latter
> > case we could potentially use a reserved-region for the PRR page,
> > instead of dynamically allocating it (if we knew what values are in
> > LADDR/UADDR.. I guess 0x0?) to avoid reduced vk functionality on these
> > devices.  AFAIU the vk extensions that depend on PRR are required for
> > vkd3d.
>
>
> --
> With best wishes
> Dmitry
