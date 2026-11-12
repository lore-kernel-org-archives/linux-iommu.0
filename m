Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492265;
	b=UthPNyNyMX+N7GjhekZxrbCdCS7bEDcNtj7laGCr0aH+sXRcBMZd4FEsLrsubWviBgMs
	 tI1EfviGaMFvQkk7y9rLyn9IGYxm4RLYlwL6e7oqZQuBScrIw4c5Z1vzTMXuoeEWdf8FE
	 sFFS8aRkq6URL7V8I6lQs6TlDxO6vEf/NZAKSz93lmUm05GkFxvh8gYmqNiRUbYUHGPNM
	 X3INTeGg690HBdGmb0zJ6vhBoweO2ZGkL7hfJ1JLaWL4ByOXeO+5rWcvaMaCB6Uthnjuu
	 mk3Cy0s4dPzirxnKGwaVCpd6RtM/4tOa/xZM7u/eNOehGmyrDZP9kSOTPGuTeNxMBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
	b=plBT0ZOCzKdZUcVMTHVQXkymIY+On6lIlJNsq9PVXVDfBKs2p9nSAf/+Ty9Lcok9DNox
	 /03ZBQeNuQeX3RXIpJof0nYOiiMrKsFwMEycEB9ZLr1qgGBOB6pJ+Knps73sQtV774ZIE
	 onmz4YiJJ9al2uHThFWdXRw5xMNLI2ux9sBFnGmK+zgdeGGLshWoXLgNCKptg+2viz8O5
	 g03OUAUX63htaVQyHQC9B9wSzhboiphx6+Skkg23F5viXhROIKs9GkFwl3Kcik0XJ8I6I
	 Uxda0NNySMNhUe7no5P2tzkT2Yzgo9kkLfHEzeW5KIqj139Ip1trmvzl+BqOrMUerxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Pt8mT/O3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qlc4RYEy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DF606AE82
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F3DF606AE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pt8mT/O3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qlc4RYEy
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Dv9k480051
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=; b=Pt8mT/O3E+MdfLZ5
	irvIgS8uLB5HnZNSkjqw9uCkzssqONuDPOuy5kilOtAmiJYPSUIGSxF9D13buTDW
	+aiq1LxgbwgdvUSAxVbw1ePXNqBwO48/h8xDkJyoNw2v5Sye+5IkGZ5mYZBhXSek
	9IbJYB9tIVir/trXeHtT9QBeG7HdB6KhiLrlaeALCLDPAhar3kGWHDWv5bKoDo3y
	b1Dsb+rh2gEqjZQn5RcwKEHhw1XJjnEJ/9RV0rfBb56LC0GBgri8dlL94paAxjrr
	w1g25DSeUfIxH8cy9wY4Y9eKbEvUgEKPcm3YmIbx4AGfryQISQPQZM7vH49th1Rc
	Ed87YA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4ry8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:04:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so8127545eec.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794492262; x=1795097062; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
        b=Qlc4RYEyJNPlJ9iyY4c++kypodxPUd4Tu2CSdiFUZfP6xYagXAvOKvSK7mOjFpnItX
         MfzxA6IQNUI6cBb0MQCZiT+JfppyUlrkW+6ZyyZpgnMiWpVj+xF8/1wWVIumF5zgQkXd
         rJFpJszFwsTKnW8ZFf8Jm7zAy34SG+Zms8RZwKIFuPEmFp+owEph6tK0anVoL7nLaehV
         U/q+OtG1UiK2LLAoc88vv+DrFf5UHSbKsV7C94TeQWyaJ2YffR2oTZQ97r15unFclp6t
         VzuXuNico2A7iwU3ZRKjQIr5ik8sSPAHQW3tvLhum8WZ8aTYlkrWqX+kG7V+Z9gSsHcr
         py1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492262; x=1795097062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
        b=FOfxEy46jGHo0+uAwWTXN+mP2YFwE2diIpgRnFKkOv9xD905uCzlDVm5+3+9yUyfNc
         WnZKWZo/UFRrOYSFv18bCu4cqFK655+cDRwk7H1SqHXey4spysM1Q7fIROva9q4SVcg/
         BjDJY4OzJ+y8W1KEifhjdpaMlnEhnxKD1VLNiNI0gwzSO9iuDEgEq1vuLw/mSB/ZkJjj
         lAIUPYzMalw0yKNYbEY7OOFqbxCCoMILiRzaGe9D+Cx19nJWaOIwTaIQ/TOgnbf3u+a3
         7N6OinNS30KH0oZ1Y8v1UBv2vWJLW2gv4/rHqEM3gRZAva4MIvWBYVRjKK8hL80qkUoM
         8v7w==
X-Gm-Message-State: APuU4Z8mROh541JIRPK4Qnov2AivQvuDBh1sT7z5QoJ0gxUY+IGmH7nk
	CFtsC+vwfEzRStmWb5McJSq5OBOyPg1X+dMqmyCW6JH7wgPexQ7H68tquBA82ezKIpFtUqY0A6J
	CteL+R7SntC7vEhtqgpITzHtf5tHe8kjFtYXDX4QmmFdPfM4HJ9GA31hUrg==
X-Gm-Gg: AYBFou0+NZ4qF4q5B9lf21+SxMyPsrcYIUoZ+sb0WJyfkSV/rq8EyI/m2EfAPgIFTZV
	Y/I1U+2H3wRxcwDcX+9kLwSIUUkm17vduZIJTnpks0TfkYZuegDAE+FUmFlHcSbu2dmbxYMO8Ep
	iVMi4A+FKwhs1vXCm9HPCYgMZWTlL0uT2S9nZWA8t1vSCaDsTJRQq01SYauBTpTMzFUxB0XI8fI
	qe047OLSmFXOQ35dQX+Vh7dL/RaFigLQXoaUahcvEyHdgx+GJqk9iSzXz63M+9QjN/G1qyGdCi1
	5ah9cWXbiQMkXggL6Mdmc7hD8Obggl4eSG1IhtPZGsjbxvObWTdVMtF6IuVZPkYWOgGPIPV0paz
	62b/Yww7eFXF2S3lnkFk3StGaGKY4ysYtosLIM6sb1MBqIsfCFuw58HQJKxA56vMoVnDjjpMilV
	V2USYH
X-Received: by 2002:a05:7022:28c:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b3c023c99dmr4854451c88.6.1794492261720;
        Thu, 12 Nov 2026 06:04:21 -0800 (PST)
X-Received: by 2002:a05:7022:28c:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b3c023c99dmr4854412c88.6.1794492260879;
        Thu, 12 Nov 2026 06:04:20 -0800 (PST)
Received: from [10.206.104.93] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5029ecb1bsm14027c88.1.2026.11.12.06.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:04:20 -0800 (PST)
Message-ID: <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:34:11 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F3Hn31ziKMzC6n0VPkIwae8roqXJFcC_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXwwf6eo8eEcyj
 WDohrio4h6Zf20qsunjRvytaMVa8J0UEGN4GpBoPzeFfC6EZh0KYHyGsB3ILhstxz+15jAwv4uT
 nBzNzLZp7907Ssyk5Nliv9SKDrC6AYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX4rPSk1L6OWRT
 nL4exUuum3sGjpXXxmoiHt1zvvx08J1ArQpjUXZ5N0YpCzI88ard9e9uzgbrdEdoGGXeOxuPw2T
 SawYBgScrjAQGjPWzz1XTnB5d3t1u0Q17ZuNp/tVDeFhGzstCP6auM1CzJvRyqJbUo5mOQF8hXw
 KmewBv3Goa994EJ9EySJSwoWzovEJfwHfpwV262TlThF4KxWvm1Fw361fjfd7d3HcMA/T3mcwVt
 9Oz9W4S87s0Qf7HVL14WCOaOlcv17IuTs9DOpkgxurflTdzJRNMT0Tl1q5XiwJUfBAxsXM2pqNf
 cALLK/kEAt7uqidDPtfg4yyNX5Sfr/LQxHUCYmT6ulGFyVjg0dmMvDNhgkSD8XUsfVt3Not/bpD
 Rz4H0RsQ3ABS/hsrK2RmmAdi7S1CQQV6SeLMDz5j6Xhd4d3uB1eTiWkhUWO16JvJQkFKG0fBeNe
 +1a+5m9YJpQDJOtA82A==
X-Proofpoint-ORIG-GUID: F3Hn31ziKMzC6n0VPkIwae8roqXJFcC_
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5c766 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=DrYjplHx1sOd6opfFz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055


On 11/11/2026 5:32 PM, Bryan O'Donoghue wrote:
> On 06/11/2026 17:14, Vikash Garodia wrote:
>> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, 
>> struct list_head *list)
>>                   }
>>                   type = iommu_resv_region_get_type(dev, &phys, iova, 
>> length);
>> +                if (type != IOMMU_RESV_DIRECT)
>> +                    continue;
>> +
> 
> This change is not about requiring a reg though, which is why it should 
> be a standalone patch with its own justifications.
> 

This is about reg, which determines the direct mapping, hence the code 
is very much applicable to this patch. Please refer this code [1]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/of_iommu.c#n223

Regards,
Vikash

> Basically the patch should state why a mismatch is dropped instead of 
> being reserved.
> 
> ---
> bod

