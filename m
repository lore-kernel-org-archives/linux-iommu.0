Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F13F410F
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679740; cv=none; b=UgUYkTVe5DgNXwzdv1h8M3nKeCDyQUtQlplG/C+9zIJ3V9F54IWGnCA677+XUaERcRuIs0QDAZxDT15xSk2AZZKNEZlWmE8q6DqukNyosWStykAroK2bw0OfD/CKiSG8PRjqzcV7+SbdWmk/vk6UpvsIJvP666XpclUO7rhz9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679740; c=relaxed/simple;
	bh=zZKNBlC8xilBW7h5Xy5kH5FOhafB6+ZvGZEGuX6Tsjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP2mBwyok8q5Dse8JgtM8PlXx+DTzyfurvs8ExZ7PSyTii0H7GQ+IFwGGjHknVWhgQgxl5SXo0sXWz1HkyQ59AkfTXeL51+/Yvs/9W0ZxJm2mEt7rR7zRWfsalsZPIYTtKr2JChGvUArPPn8HYHqEdWd4dmGRiiERwJUp3YYdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maIKG54s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AALITY+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maIKG54s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AALITY+r"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAVKrb3430137
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wRAyE1rvzIaDWQ+RxvchnyD8
	UR33n1c7hVtXAq/JTAQ=; b=maIKG54sAD9m+ygC9YpZq4eqrJ9UIq8zWmV4FF7e
	YTe9yf6VndLIYCvpjSwSu3NbVUKOCv/IgHa5jzdOl3B9xRmfiPEQ7B+0WogFcfEE
	xxU4VF+MJd8P9Zlpl/tzlLFj5fba38LYdkPlCxsX3aZDpJD3Dq6cVmuh+ADl2wpG
	zKT6cpTrQn2uzYeAYbdwfQIAxXYBfxiM+MRMKhK9gBObXva8Dn1Q4i575hjFCzQg
	9nmUeW5DK06BAbeWQwB6nN5I8LDuOo1J6r5OvF0rH1NgrYnydoErj5bFvPETgStE
	ffIiMxIJ5S3jyetoO5i5E07yx0RMrgmGHKbKerwX78TH6w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcgnnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:42:18 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95cdcf8363bso2876168241.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778679737; x=1779284537; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wRAyE1rvzIaDWQ+RxvchnyD8UR33n1c7hVtXAq/JTAQ=;
        b=AALITY+rrJxPfyDDx2loo7XK64o7IdF1dnSvtukr1C5/owPXvDA40dJgb28FNxMHeJ
         jMzXYMMaroJwhfd2ObaeHJI19qWH86du8cJLVJoyvrAuuH/K9FLr8PtnlOiBKnsDiK5u
         CzHMzqgIMPbfYA+EJOok02s4gMNovrme4+s8+k4VxLLGuUBuOhOLfgJDBheDCqAgQXmI
         xooF6/n4vyzL17fIZMhxJ0q8O+HC/upcEUwmLphgHgLcuTMQAD2TOF+xHz8+Xu/H0xh3
         Hj+KhhkSOifS4fkhmLHrwFRWpWDVoNP/Y1OsLIToVvAFpMHIL2XlecIwz2SNiRfGRW3g
         4eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778679737; x=1779284537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRAyE1rvzIaDWQ+RxvchnyD8UR33n1c7hVtXAq/JTAQ=;
        b=EeRbtosdadMDGRCkJvZgzRVBmJGlM12XSXOWXDt1Urpbgr3dhI1pQU/RICrutwoROq
         /LXJFmvFRiTejBADimlEX6csqzBvfKrsJR60RyJMsRGCqkY+gjYIRinZXaogiBstNve4
         Pzn/NuFb1ge1L+trX4GKsJhhqRmnmgTNgbEzOQUfe7Jt1/3iw2JlhXtQ0ybkL0L20UgK
         6keFmZ+Q2c5Lzik5dYmm8eLNsLEb8ZLPokjoAuDAEzMjKLwjYi4Hz5ornXokQ3nRKKeW
         uxGKIqzcwlBKZLyq3IjLK/WOfMNAbWqoSKIPsq3FxrsngXKnQzipQq+1IXKUEor6Y103
         3v+w==
X-Forwarded-Encrypted: i=1; AFNElJ+yke3uRTIupoO2pbBkJbadhapB6h9NKb6SXv0x/OBWGJ/F0eXh3qXRjIi0+6lPHMR1TcL6ig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+5BKtQiz8g62d1e3QlZt7K6RPTMO5ypKV+8dluHMovhHn22zE
	WE0qaZ381nwX62Fl+eNZOvWGnIgbNQdJ3AlGTHM1flgTQjVRjx8DccQCJ4gy7elDWjzDlaRyXit
	7pEzJ6hsgMdGdwERC94mHsKjHIJ5zIHAyf1C5S8VROFyBlq088++mGABVhg==
X-Gm-Gg: Acq92OE8TZD6L2SkBY0LKh9bU+8mu5CbOU0k5m0Un0POpZSPc2BItlvWyslQ06odvu/
	k+h/sU0rI+dTQohPA+gMX+MMdBEUOo7vurQVp5GpP3luRyJsF+EkiuvJUWx7N2xq3kHPRzzZ1zy
	PoK0FjsoNpCoElwJNCqAdLxk1iTZCqwzjQsh8JqDRGWEM+q/rm4gBqcT17PqjSPc/rIDbtHR4/x
	AGi+uuO8rnk7DcvfFMrP+1FmMJXg+MId0koqZfw7szF3lb8AKAWxALyymirAMZgi2VB8QHqHX8A
	OBvGfcZQrpIfbKHgwIeH8YWgPMexmxZElPMaHpVAi4gb9Uyp9uGsivKv6ocNubb78YUD/dGn+nX
	cANc0TsxC/CKfgeA2ZlTRDQTyhy1d4Qop6iGPEhKDKj0t2YJNglbcLaPD8UXPQ6TYsMar3XLPMr
	ooCsz/iY3QAOJ+JrEGHHq8epWIFbi9xXzn21s=
X-Received: by 2002:a05:6102:5346:b0:634:92c:bdd0 with SMTP id ada2fe7eead31-637a6f3af24mr1123892137.6.1778679737137;
        Wed, 13 May 2026 06:42:17 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:634:92c:bdd0 with SMTP id ada2fe7eead31-637a6f3af24mr1123853137.6.1778679736046;
        Wed, 13 May 2026 06:42:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956642dsm3976983e87.71.2026.05.13.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:42:14 -0700 (PDT)
Date: Wed, 13 May 2026 16:42:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <zaq7evuw6la6p6zcv5zgv2nuehc6yxt6xxojjdd2rdflxtk73e@wr2w2kbxamv7>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
 <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
 <20260511080104.c4nhhmm2xgzm67fi@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511080104.c4nhhmm2xgzm67fi@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-GUID: Hh4sYGAqfyeiGqdvWa2rnJg8Tvztxhrb
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a047fba cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4BjjeKLzrOWpEDKIceIA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MSBTYWx0ZWRfXygsth0SeFGBG
 qWIDQ9Cu1gs3vhhnHT4UQ+WnCzd7SYzdolISEN66Gz7C3HVeE4mTy/iOIZczLFJxkSuZH3wOIkE
 AntPvjBcxosQTxVBkr8VBtU8v8Zcj5xtN9aTuNu1nDxhw2mUdmO2yTFpjqM5k/WmIzraco75RfO
 9jt4/7F1u4fMa9/glWpVr+9CPSzL5njhjt/GKKNbNwB5i8PBt+Uz7T7n5K7AGvWKqYE2FPa02dE
 VHzBIo29f3/zNcF2ShYwE3eMs+YmFUvnrXrQgd5ArFatMn5MFkN//OFz1CDKTmhUXTqbgH8icq/
 lMdVoJBhCWug9Km8L7JDo3bgQXiMwi6Z8QEGJOvG1E73hAfzpdNNYxeg6zp6yYNWctSGpRctO5b
 +s8O3VUCoUUCUJaOMS6LSTeovJlKC7H0MKdTuTzpaKKnq5PXENebUhOUu0aXNeR/48+QGiYI5PT
 1IlE8Qj6pcMq2NsLvpg==
X-Proofpoint-ORIG-GUID: Hh4sYGAqfyeiGqdvWa2rnJg8Tvztxhrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130141

On Mon, May 11, 2026 at 01:31:04PM +0530, Mukesh Ojha wrote:
> On Fri, May 08, 2026 at 11:20:06PM +0300, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:56AM +0530, Vishnu Reddy wrote:
> > > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > 
> > > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > > or QHEE), which typically handles IOMMU configuration. This includes
> > > mapping memory regions and device memory resources for remote processors
> > > by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> > 
> > No the calls to those functions are not intercepted. Doesn't hypervisor
> > simply implement the SCM calls?
> 
> All the SMC calls are intercepted whenever Gunyah or QHEE hypervisor is present
> and in most of the case the preparational work for the TZ like in case of
> qcom_scm_pas_auth_and_reset() it does create/register SHMbridge over PIL memory
> so that the TZ can access the memory and then calls same SMC call to TZ for
> authentication and once done it comes back does mapping the PIL region
> and call bring up sequence of the co-processor.

I see, thanks for the explanation.

> 
>     SMC  SHM setup    SMC (auth)        map memory/resource and trigger reset sequence
> HLOS ==> Gunyah(QHEE)   ==> TZ    ==>    Gunyah(QHEE)        === ==>      IRIS 
> 
> 
> > 
> > > later removed during teardown. Additionally, SHM bridge setup is required
> > > to enable memory protection for both remoteproc metadata and its memory
> > > regions.
> > > 
> > > When the hypervisor is absent, the operating system must perform these
> > > configurations instead.
> > > 
> > > Support for handling IOMMU and SHM setup in the absence of a hypervisor
> > > is now in place. Extend the Iris driver to enable this functionality on
> > > platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> > 
> > I fail to identify, which changes correspond to this description. If
> > it's about the PAS context creation, could you please be more specific?
> 
> I think, commit text is trying to tell the Infra to support any Secure PIL when IOMMU is
> managed by Linux at EL2 and the dependency related to SHM set up in Linux are done as
> part of [1] are in upstream.

Ok... I'd say, this part of the commit message might need some
polishing, but I can't give an exact advice here.

> 
> [1]
> https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/
> 
> > 
> > > 
> > > Additionally, the Iris driver must map the firmware and its required
> > > resources to the firmware SID, which is now specified via iommu-map in
> > > the device tree.
> > 
> > Why? You miss the most important part here.
> 
> Sorry, I did not get.. are you looking for explaination here, why via iommu-map in
> commit text ?

Yes. Why are you using iommu-map instead of listing it in the main
iommus entry?

> 
> > 
> > > 
> > > Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > ---
> > >  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
> > >  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
> > >  2 files changed, 66 insertions(+), 10 deletions(-)
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> -Mukesh Ojha

-- 
With best wishes
Dmitry
