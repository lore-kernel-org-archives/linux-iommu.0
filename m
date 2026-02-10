Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3230F7FB
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724849; cv=pass; b=U6j/0+72FOEDPJZ1DyFLzYn1pCZbMBCZaw5+xGxtBDVVHARAhM/ke+y/Tp62ZbPy2wsGTN6QxM7EgE034w+asAueSwYqnqpCW0pS4TIcV2pZllMT3qp5e1kmND6IfCktY0DITiprdx0SKb2lJ3iajtW1Rdhy/4Xvi9BO5h+UJs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724849; c=relaxed/simple;
	bh=YvQqBzBDIT2e7LXYCdzJ5n+jCiv7TZyJ2eNvdGkz7CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEZu/faqPExPhrlFXt86ogQnilmBqxRI1wfisHXUiYI3VFiyg6UAJelozwIT5gXP2xn024YtHLtl48QUTeAGoYOaekEuMcoodA9tvp8a86gGgjzgnMZ4YVzAY+gMS5sU8dGOACUKNsWniwpFmqRv/8MYYhmdbMA2iCYAFuPwY+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6ZhEfbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A+CIuPGi; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6ZhEfbn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A+CIuPGi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6Sl7h441429
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 12:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kkNOhm6UTNF1pjoKgOHChpe2
	GvAzpQ4CZuki5UvxwSA=; b=j6ZhEfbnuxKQVDNFFEBpE0chm6PkEij0iXRrRazD
	O5MJLRInEblrbXwC3Rm85xNvr9M67xVWt5d7OcVHYbf7BK5jETQqJGM1K1S94XTk
	MKWkJnsdBffhGjeCxfuH4PhyjBijDZIc+vJ3ULLyInkc1dclH1FUyr90VCi7eYRj
	JXVr2yH1OR/A51AxnI9PaICaAWiKiRu8EkasvmjvJX51kHUfxj+sdmhNJwSnRcbc
	jL/XGXUg4NOTAPhCuueeQXi2VqjO3k4/5mn9Jy0mq4C3aXFDhPCeLKmBKp7oESTq
	G6+BpGyRJ66C/i2PFj0BZy/TW9FS0rHxXQRBO2lkswNv9Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9jffa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 12:00:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3545b891dd1so12046757a91.1
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 04:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770724847; cv=none;
        d=google.com; s=arc-20240605;
        b=VkxN+kSWBCpNe9O0AwPDc1G62LSr72Tg/9picNyS06nJxe8GuChO8ZtVpBC5zLaGSd
         gbJ9MzrwK+q8OBNN6qGhMEG17wMJYydZX/a2wlofCHK4iCdkKRD5+PlEyo6Zo/EPrBTv
         MFk3s7sQXHMYXDpKe1GieH9WKbvVUCXNG0dYyrl1TJWnWVxi5Fdv1NZTfPm74gdBb3RC
         CBcBYRNMJqGE1g55//WbFoziYQkrii/XOBYDllQ90ZqdyaFoLboIfNPXiG3+lzXens+Z
         djPUVzFwbwKAfZB9qgL/+SyrHGdfrzUs8W/P3bdSRwZjrOIehjhgCmKvWbx7bQN3gLmj
         e5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kkNOhm6UTNF1pjoKgOHChpe2GvAzpQ4CZuki5UvxwSA=;
        fh=7GARBkPtYGvj6hlUdSJDHocjLhcw1oZ/DOfHsg2xudE=;
        b=ObD3ocLv9Lb9zUjCvO/YREDX+u5P7kCbDm7/Mqo2EmLEMJt4HDMdPSJhvyYwfvypT8
         MAZL7RW3SURSUXPRaD11symnF3z+SbM0zqTVbRkjtJ71cc1ySJ8iEQ66m7lyeVr8Hyre
         NfdoFaXOJz5BcnSL70z+Ol2y86ZP4UvBEv/UAsO+MXl6xErSLdTTaaJsUdQSvDR49fuE
         prLLotVgEoW4FZKDdMIN+amjd+mb1r2TTpd8T2VQ39ckWacv7Z5AUVTI+qRIQlD/KNuH
         I7aPvsrgCcjIGKpkePePcTJOAwT32bWqbVDuTrsxAdPBICHOiC0OT3iFTWki6NtsnkmJ
         5sng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770724847; x=1771329647; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkNOhm6UTNF1pjoKgOHChpe2GvAzpQ4CZuki5UvxwSA=;
        b=A+CIuPGixIs5QO7djPsvVGldiuZzShpeneUgy8ueh+N1LO05YBPRQk9t7tinPf4JpS
         auwRm/yhOtkxC9a4RagV3HmQlIhqp/td6NuCeTkxCP0EEa8B0uR/dO18uiu0LFR8IWF2
         O6+V68mnu7OoeOGwF9/c23HtIQYfeOJ34u4dIdzW3EHhHOLvfqOxkOOFSCCPOin7eXVZ
         V+v4zpnr1giCA3BywfYVlXzrt5zG7HCAxSkhemOo5PaCjufoK6RijRy+l7b9F30VDxvz
         Q3dnP6yUmhbDPM2S4WAQNqrikWCB7O746+5cASqqP1hA+omiAZ4xyO30CoDwz/CxNEmM
         ancA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724847; x=1771329647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkNOhm6UTNF1pjoKgOHChpe2GvAzpQ4CZuki5UvxwSA=;
        b=vtAh+PzIDD1B5Q5gG9LTHy4+63QjhC9DZ99B9btuDK+JSZCQpv7mGFWlxNsJDRynVA
         BSxctS5P1Gbtr0d2AIRqVuSQqxcgnw7syXaaxJymsUwLzBA55809xbRexaxODa8YrGq0
         6/joaMigqMhiN2zVknTBQitGCUDSVpwo29ApgiyJ3+eRFdK8grqh4NGgMLjMSrrOe9Dz
         wYjq2t/U1vLR5bB39IjrxJXD49joWqpPoMITMf2pEBUBNNpAkQA0lAVoYpE3RlTDUvip
         iRYkK6lHUK/oA8KPJYvxsJlBy5iQl1tdFhvCGpSMuBdbtUqKCAIWKsIfSkYzLEadXQXf
         aIEA==
X-Forwarded-Encrypted: i=1; AJvYcCX6IXBVAVTSlVRhSjHeSQaJid1clVFktt88CPEbSQMm/p1E6wnqWFVj9s4W1oVezmVdl5I5CA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKrY1hmxN97E2VYhs3M5FuIINso3AzH4kpdcaGtz/Ip58ha7pZ
	Gq8AnvyuW2/7CuaR3U9Sf5dvbRDeHoUms6EfpNJc0pVoRdhDCN6U50o/K4oh7GmR6CQ7NYVw4CA
	2SUfQArg6inwd2EMFGzLNb9TMehUpMi2gADUHSAmT0HZVc1VzzB7/9kMvk46EJZtUmGp65RRG30
	EyMJSmg/exHo2MnD0djG6bJv08QHuSrEFL
X-Gm-Gg: AZuq6aIHzWRh41PDXh7IeYNjP0juNFnb4D3WYk60SELzwne99keZWIqWL190fgTYKNp
	TKig6rdhf9Nh/pUoaVWrJb9aWR9qX93HsRO7ivxqQhZNnjuKeQbwVMkHBwutZ85aaPQ2/mrW6Or
	Wy+bDSgHHT/4USpckiM9YLvVdwqLEeBU0aEl9w95xu7i2jRmQEsv8siiuf/BV5evsX/puLtrZ25
	eDe
X-Received: by 2002:a17:90b:2788:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-35667da53d8mr1673479a91.37.1770724846466;
        Tue, 10 Feb 2026 04:00:46 -0800 (PST)
X-Received: by 2002:a17:90b:2788:b0:353:e91:9b2f with SMTP id
 98e67ed59e1d1-35667da53d8mr1673442a91.37.1770724845888; Tue, 10 Feb 2026
 04:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com> <20260210101157.2145113-3-vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260210101157.2145113-3-vijayanand.jitta@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 14:00:36 +0200
X-Gm-Features: AZwV_QiML8otMkecct1E1skSU9WeqWq86rbzn6_EO5wuJsDWXxKFk_hLjqxo8cM
Message-ID: <CAO9ioeVwPhbW=mkGUZQdCJH+C=KVf1bm=SDkoDinrj+nD94s3g@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] of: factor arguments passed to of_map_id() into a struct
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: eF7jb31CWnWEUffgQlVaugZLPDUqP45G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMSBTYWx0ZWRfX1US1Rr2IEYBq
 8xUZCly0eMm+mRh8w0BvECAT2wNoXjnSGPFhAlG2KvunMty44KuD9feQ6UfMpdJr2yJNCZYxLz+
 9GpI1bw1ffvVkznCy5bf/MupUEvUeP8uIx84C4etvLiNsRVWdYQTgo6qAVkM0YU5uW+1vdgYQbW
 9l0DHt/fYcCj4VGCtOCLqhd3R4xapVprT2OlILT5LbuV9AvylUrCPWi3VtT1xYckRYUYus/h3Ik
 zQ8FwSQ+uweRBpLfVNDdePPNk2V9tfNwVXRV4n4FcOEZEXgCAqMTfe8wDUenpcQCgXeK4AT/bJk
 yqp9zrE1ARFDM5hIe0VIjDC8c+uqrkUwqG0eNM+AaTqtArcsLMuxOasR15290gfjhk2BSB89Mtj
 kQuQSjhjBnnnH5u6coKeb8PUYrOwtTajyKI4nnrubTFl66MFtBzwxxoj/t9JEcmjBbRSvbV6mIv
 2OGr6Q90evg1tl1vlFg==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698b1def cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=xaxt5VyFpAJ7rQpQ1PcA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: eF7jb31CWnWEUffgQlVaugZLPDUqP45G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100101

On Tue, 10 Feb 2026 at 12:12, Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
>
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>
> Introduce a new struct type where the optional arguments passed to
> of_map_id() are Currently embedded as of_phandle_args struct.
> Subsequent patches add additional arguments to the struct that the
> caller expects to be filled of_map_id().

You updated the patch, dropping of_map_args, but didn't update commit message.

>
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>


-- 
With best wishes
Dmitry
