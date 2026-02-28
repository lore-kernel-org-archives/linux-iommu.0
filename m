Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485436CDE0
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263890; cv=none; b=YzP9E/rAffaQHvonpjA4VO2Jg+fAF6s724RF4CfRaHyAy46DwZlathMPzE/1Jf8j1Puqqy/hwJ6yKI9AC/Jrajvumm0tKLqlwhSzjxmc0jrF1LcO/DzY6VQw1g+nFlBfbD6jGcl5EN1bVWiJVJslKfqUjn5TmDn56nUvX/76ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263890; c=relaxed/simple;
	bh=0hpXyAKupsYx20QK5LU24bxIUf4zGuuCPOC0wLlS610=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbWmfstHGLSiu0J4founDpkXE9jSMB3LP7kyGBW3eXH/Jspl0R2TFpnqpF4+dT7QIPIFgl/sWjhJSk0gDrACC5CmDR0G0lXiAR6T/vF5QsZLgnhmpXcroZrAyPW34v3tQvNpXiAAJuJo+Rr2ZGPmSYTHgbYzm8NkBxFSCpr089g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kltBAFth; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T+KDjIIm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kltBAFth";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T+KDjIIm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S6W4v83590238
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 07:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fYIdXnJiTNYA86ojQfMfZlVy
	fuRE6VoZ2Cddr4hiJO4=; b=kltBAFthS463PfRaJ+OxjfybWUMpMVn494WMXU11
	dPq5ToUuT1wTqppYoSSLGJmi7sYxmZS+qPwwuNKEmuZPDXkjDa9eBY4aFlJ9oslL
	DTjPhfQjox/5y9N6+4fGZU0OsLF/bWmZbEJCe+uRuxv49ga+G5rZ+jvm/xXk0wh5
	UNIQevBzK1W8+AY8bhK7UjuPVO7JyqI02tpnjFF0VyGk2PnVEnYrxZzGj2uxBRLu
	EHxgUgtY9sSTAzMLR+lv9AeQtf4QZFgLLBo63YL/7jr6fpuB949lf9zcu/rshaPz
	O6QyIRsZNtEUmRlU9/rClUlmusFbepR8iSfg5wDCFgmonA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6gcrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 07:31:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb390a0c4eso724924585a.1
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 23:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772263887; x=1772868687; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYIdXnJiTNYA86ojQfMfZlVyfuRE6VoZ2Cddr4hiJO4=;
        b=T+KDjIImm3+ckPfBGWQXh1CoRLegzK47gQ3Z0L1cm0nqULEu4zwfPtzq9F+HmKcFPW
         ohQiiIVFhpsIIs9gQI/mfirdQ7CfJDG0mYqIhT4a80b+r7sBK8XLRPtIlIf6r5Hpmbnt
         2tbWxm4bN1TlhPeVuxB1sDjiO+tf6M9aEhjfKnWXffiveHoxRJgFGhcz0vgI6nXgrZyg
         VrWfomzIi8AVfKjFYdnQ5nsNzaoLb/hibvMDeuZe1qDdiZiohIl1tyUGAIErEwXZdFFM
         Q7LEP7/UdjGnZg0PWscqwK3ahkeDaD10sAh0QrDEkUCb5lQ9ObhPjBtIHHuG5+JMP0ht
         PHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263887; x=1772868687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYIdXnJiTNYA86ojQfMfZlVyfuRE6VoZ2Cddr4hiJO4=;
        b=qDiA+/0oEBmo7xWk7FDqTc23Cbqmn7UYlXXd+iU+7saF5gTT9rCJ1Gk2lQTsLGux1q
         tiZnJpu+mfZd2K44jeoIKYLJ2VUVKPNsePpEPahGWEAolAZrdxk9FSGBBQCrewnd/Enp
         gwORw70ZB545H0z9tsbGeh6fkbZR9U+kyGBok+uAjv50ca4s/9xYPqH9VzN2kOtJSSXW
         WHlgxncSEcfEG5okRKPxxrTNq9Xcyebpb6qX0gzJ+N0a8XGK2k/MV13vRAMv8PRqP/Dh
         H+JR/bnE1rx3NaQZ2yB3IJvJz+aouuwEXKx0x9yUzUPfFBYOmoRiElwjNa5fVpgXonaw
         XcPg==
X-Forwarded-Encrypted: i=1; AJvYcCVXcQ2+uhU3Uj646fG/fnPTgZdzUa8mLhtsnxhwwjxOitwcNYVcgCztTfhfN4cJAkZ4mMCPGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVizS31NAlr1kGwADzeIibqT3WftWcF2BES4YQtTnfFoxkmZMs
	1Hong3LmpZQYRh2gLi0xH6w73H06YZ+cbo1q3atZ8igsHXjfsBm0sPjRbOhUKqfD314aqhrfMCl
	lhbf0OGNuBPi3VuSHszqb8qYT8ETQ8+4iQrlI7fDXRzkDwzJQXR286p7Ewg==
X-Gm-Gg: ATEYQzxxAHQVfm6iithZVhpZUsjcD9SbBRCeY8uZrGb4ARg40uSIoGbqD7y7p9AhCeW
	kOg78a9t56RfZ6imDC/dEpNX1g/EYFHNuq+WuRhZTIJY5de0iKZdqwJmFWNLXObIPdE09YHInWY
	nRnF5xgRmgdADVLj4R44VYfCzLudGUYOusCeS4Pk3F0bSIV2ziRbQggICLTUTQuzhHQdV91vkXi
	OXqBucwVTesqqD7Lg+4JOHGoPQ4AoekfHrvxTSY//dPIxYeyuOGIS9IutcTQ8liJvupu2bQxrnI
	Xu724us4sNZNQxEgKRjp1OaJ+tlGYSNtkPG7nowPxp7bVR0Qagf0YUJDL0p9aggPquBa9n5VLeC
	UfXknk+UgJvFL7IN6gp/vLDr3uVQopJVKCrkmCshUWBnJ4JYqTAZPcLgebDLjQQ72U33kdYmpnM
	7qnZp3PGSBZWFXZaRAN+nYzZpJ3CKCUUs4Tts=
X-Received: by 2002:a05:620a:29c1:b0:8cb:55cc:6245 with SMTP id af79cd13be357-8cbc8d6f198mr740531885a.12.1772263887385;
        Fri, 27 Feb 2026 23:31:27 -0800 (PST)
X-Received: by 2002:a05:620a:29c1:b0:8cb:55cc:6245 with SMTP id af79cd13be357-8cbc8d6f198mr740530285a.12.1772263886948;
        Fri, 27 Feb 2026 23:31:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bca099sm424138e87.32.2026.02.27.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:31:26 -0800 (PST)
Date: Sat, 28 Feb 2026 09:31:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 7/7] media: iris: add platform data for kaanapali
Message-ID: <vxucx72fpppn6ujujht4whfanbv5qs3i24cxo6zgdjvvxaaoty@twwljn4jpoes>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-7-850043ac3933@oss.qualcomm.com>
 <de8879ec-02cb-41d7-a16e-aa6d4aab983d@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8879ec-02cb-41d7-a16e-aa6d4aab983d@kernel.org>
X-Proofpoint-ORIG-GUID: buGf2xC-MhtHM6FV8YZVSGunuEWC0gSs
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a299d0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=1ZbspG3SCIlgkd432K8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA2NyBTYWx0ZWRfX6G7WyT0btqQ4
 nVkST5fk2fDHLAhORRtU1JIEEe4MuGoLfiXfA19asPKoZ/ugk4L5Q58X70qO7R9ybjnsRIgJ+39
 1jw/m7qENp1GSWKWv72rBx/BQ+QxlNceUDSUpHYiONvOwqiLAAbr4D0DuB9Jff66Kg/9mzbSUMB
 94nWqX1CxkhOntnYExMQTaFBHYtwRV2dXOyi2lr9XZ/9FB9z34/LyTn7EOl/1mDtWYefnpY0DOw
 ajEvM+tT9jhlcdBUA8aJlaRYI3tD32tup1Zy1Gsi66q9UpSTkC9VcpopXIyOwJxzc+qL2CaYjwr
 EHCsl8RbHADtzbAZukLYcwijVSBCQ27tgHZuTTp0IgEp46IJVy7pHNYpaLntyj7o55yiRBVw3eC
 uhx24iD8X/O8sg2HrKyq8hDFoqYbmYremorP+dTfqOwW56IV/3Fq56Qi/xiZNnAehnh9SGjRIfp
 dA8vHS1BNvwkH+/vUfA==
X-Proofpoint-GUID: buGf2xC-MhtHM6FV8YZVSGunuEWC0gSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602280067

On Fri, Feb 27, 2026 at 04:48:31PM +0100, Krzysztof Kozlowski wrote:
> On 27/02/2026 15:11, Vikash Garodia wrote:
> > +
> > +#include <dt-bindings/media/qcom,iris.h>
> > +
> > +#define VIDEO_REGION_VM0_SECURE_NP_ID		1
> > +#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
> > +
> > +static const char *const kaanapali_clk_reset_table[] = {
> > +	"bus0",
> > +	"bus1",
> > +	"core",
> > +	"vcodec0_core",
> > +};
> 
> How many copies do you want of this? Data definition never goes to
> headers. That's standard C rules.

It's not. It's a custom, but not a rule.

-- 
With best wishes
Dmitry
