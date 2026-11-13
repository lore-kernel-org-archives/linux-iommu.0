Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562600;
	b=WwY39Dv9Y4d/ZkdNP6b4/nu7zfXo2J2KnaWXEP5cs7x2g/G+E+zvwaLlSa1ZRaI1Q7X1
	 cGZffdlreQ0BdFHNtXzvrthVM4Ize30/TOe0EiNauKkU5dr3ckEyl6HGkZtAp5nVgASCa
	 O7qNZLkGpnNRVxp/be1O6KYPNd3xxTa92kSe2gP15Y7i1JwWuRW4Ovuj5kYecumU9dEN6
	 q2cc10phe1XvLQPWx1LlzppCVR55apfKDNC8jm0JIyMR4+Fd0rg1aVZwbnLGlyRvBzOoS
	 SZGPcdk+XATfQoB2W1lGT7v3HF+Cou/2AZCVPreMbghoOu2kUOpytgzT6Y62QJrv3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
	b=5l/JvkNUuzg4B5Lj7+s7IeaFfyLH0lTdhUj3mIg9gmE3ZmtjNwPCqcyRLIpsNlzphaeJ
	 5ga4ekfIqwWeUTw2o8fTKd4lD1yhogPwPZ/Buca5f3zeFkxJQfSeWkTY0rznk27Qd8w3J
	 tZISbKX+D2iLqqw3dMeycVp9beG2IA0fgil+jAyJtaVtipCMRtb7F3WmAbJ5mZ3JIu1vK
	 ofcIO/yLqp4eWkQBhwC3AWIX6LttoSr76evDUdWr6g0BaohHb9dVDTL1fazGLOcNkiUS5
	 JMDaTM9KuLJE4TDWpc+PFzVMRYrgRqVQExDsn1EWaO3qk1ZLpGMFe3AhPMr4WegIIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GVKFGMs1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EfcCV3JW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0F606A31C
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 09:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GVKFGMs1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EfcCV3JW
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VKMD2515666
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=; b=GVKFGMs1XMs9bbXp
	Zhg5r5J6RwMc42vPpYNxUdrGnsI4Fhw2BdDU0rdu3o0sFmMKaQu1NrcR2rTbbR8R
	GvHPsp+4adGh3QtD7FPMoBIFtRHYLVkbyZChjnR/NLvCdmjR/OrbJPj7fl4qeV8W
	a1ieVPsDJG+7JDIGNw/V8eBuedTZbN9Wy0yyelW2uvkedT6T910Pio8zORxPVIZq
	cgFh3n80GjMVVrvJDu3INzRywdH0D4acbetf4CAQIkFyDea6uPH4cEbOmx5UmaHp
	nwj/BjflK9AxQPPF1ZvcJ3MYKU+dUoOYlXPQrcNKRYBmmtJfK/Ul3Q6ffcQMlx45
	ZG45lA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bbf12-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 09:36:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so1115020a91.3
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794562597; x=1795167397; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
        b=EfcCV3JW+DjlHjYi41DySCxmjepDc60bt6gQhRgKGARavzPW4Q4vaSzrLyJNvXD/xC
         3GJYLvFSa4FOLTmy0Ru7DByZ4yV7ZpVnyygUDaXi7Zjh158J9D6Hm+0QtUulLrr3GkSM
         lT5l+Zj99DUmhDqeya3nFK1akbMm/EAfo5izGDEsPFcFpMgmmqu25JqJ/lHZLWPjqU9S
         gjf5hFa1qNfKevLWdYlCzOe48BJrdBbDOmBCWMmPjAi6U8YgE8tasVT7NQdQ0/uniEos
         MUsBbTL0eZ+GdQAX3lXqJQXKQRK3Q8xKf5+YIQFfhennr08YBv3TVAz6JK6SmIm5r+wo
         6onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562597; x=1795167397;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
        b=aeWwry+fjGx96nRclmpAMQRQs26JnufC4CvnF/JODeMhWfx6dUeqny7SMwR/qGy1Ng
         KopjUnECrgQFuAPdl9EJvlKPQkWOZtUTyZcugDoUEjlZnzLLTNUFef1t1ulGjM1YricL
         tZIr4dd4mkUPzyB0B8LtSZ9Y3owYjUihdlHOItnaisGHionR21dUOVUODHvgwHab5spH
         /tDVDrIZ0qkvkgsgD8e6bOoprYYJ9ywQ+rhWondJz59iXTfvFXyD1tAJjwlQmvzRokdz
         FzhYMG74Br/CGgIBoKwSKAXR1fCw339T3wKbsCX3OC6MO0hQjnX6FmlenS+CEaPwsywB
         znjA==
X-Gm-Message-State: APuU4Z8Z2SRV2/nRfNKwMX4X/cagg9mk8DPQ4nE12D+8zgtkSawx7vOa
	K/qaUiYljTmzet1VoPyRFP6owg8+DweAcrWJT+9MS/zAd6SYy8oddoPafjAncQqArFgBT8LvV5p
	3aWTRzjwIqE1YJm41Mg26wkmllI0NPAeRJ4dEWlLR4flNHmWVKk3fn68/yA==
X-Gm-Gg: AYBFou0PIHr5HIkvifxf4pxxWW4+lqHfVsbhdMAJwa2HTH+eEsaV5I/+TS9CbcO00fv
	PyAJF3DtvGFyzYuV3EDRJCGOYz7acd8dGhxEYDmd8awmX0Cu+COdasYOG1+gpO5UFtVWnwTuMTt
	OnN3x04Xpg7eRy9vzAlAKT1Pg9j7BQcKfo8+v1RlwPb1c0FGpBWq+QsJnPfFE4KjPhuQhj9DgzO
	Pv01YU8Bp1i4b4ISwjZso73HPSQWwW87bURxdEgsSo+1RNL/gvP92PT6miI9V0QZeR1K034Q1iR
	/SPZ06J0fGDFc8qM2RHcOI/DeWku07tx2x8Uq5uZj4zRS5GEjKkJ1k07C4sD/WwMKqvZrzaHJgn
	Ueb138tpSTPrZye84VgBpddQKCHmBNYKLjcNnoUpA5j2tW5eXBmi9x1fVDlD8PFiQBDi6LAq9Db
	UterAisNlrDmjeZtXK5/exsC1CL6PRVZLyr50L5eU=
X-Received: by 2002:a17:90b:1652:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b1b0a42b8cmr1747883a91.48.1794562597505;
        Fri, 13 Nov 2026 01:36:37 -0800 (PST)
X-Received: by 2002:a17:90b:1652:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b1b0a42b8cmr1747854a91.48.1794562596993;
        Fri, 13 Nov 2026 01:36:36 -0800 (PST)
Received: from [10.133.33.5] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm3828201a91.1.2026.11.13.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:36:36 -0800 (PST)
Message-ID: <68bb5fe0-9005-4517-aec0-c39021a5b24f@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 17:36:28 +0800
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
Subject: Re: [PATCH v7 5/5] iommu/of: Add support for "iommu-ranges" on a
 device node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6da26 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BUd8g3l6cCjgLUHkIXsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: U_tiEX9i0s7cwLwyAl_olXhn4ro5l_A2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX6kLAPYsGyA41
 jLpAgUQ1mM6vDzOssC8UT4CkPSsMv/t4sZRvd7z6GJWdV3xcPIWkqVKsmYxVQqfTG/BPcDdFlbq
 CjW4AcPRTKdT9bvXLmL0JwpHgSQN9d8cKj7iU1ZHvpOVUlKBAf3/VcIpLaStexbE6i8JmzMI54M
 KqPzhReCqME7Y20ZusyQQ+imCxtA3xUxYUpZQaoTzuxVfaLb+pPur0DqC2g6C8QlTx6oL2qIbet
 dRRvWtxfU8BJoJWgv8G2lGEMI8ldGQHgT2N0A/ynlMEA+uBiflJKV5zcsA5pwQDhaPrLdMucd0R
 9skrj4v4mR3EKxgJe7KLC7zbx9x8yqCo7fxhnH1q7fxTHW1finSV8r3QyebzuqCX8AQ6T1Dayqd
 tDdE/wVnjiGPUoLf0T4sSxXOS1zAI/1H1Vdi0+ohXVZbtjcmYBZeX2g5VGdh/slZ6tVdTcqm/hA
 030XrG0nMeqlWjOw8Tw==
X-Proofpoint-ORIG-GUID: U_tiEX9i0s7cwLwyAl_olXhn4ro5l_A2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX+ab09HDaeaHt
 rPgSX27li1UC0brJ83DtQE/jhxB0FNYhyhG1t9ZAfmyu5wzwpU8jIQcfdT3tVOeuNSaAoknElpw
 PuUl/GWccZCOrM873Gd0BGB4s14Kl04=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130038



On 11/7/2026 1:14 AM, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> "iommu-ranges" was introduced to specify the device specific IOVA ranges
> when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 00b02c19f27e195fc36c4bc1d91253255147c9ab..e133d3b346feecac7e2bfaec44e4882060ee89ec 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -183,6 +183,111 @@ iommu_resv_region_get_type(struct device *dev,
>   	return IOMMU_RESV_RESERVED;
>   }
>   
> +/**
> + * of_iommu_derive_resv_regions - derive reserved regions which
> + *                                are outside of iommu-ranges
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * A device can describe its own usable IOVA ranges directly on its node
> + * via "iommu-ranges". Everything not under those ranges is derived
> + * as a reserved region so the IOMMU allocator won't use it. Entries may
> + * appear in any order in the property.
> + */
> +static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
> +{
> +	struct of_iommu_range {
> +		struct list_head node;
> +		phys_addr_t start;
> +		phys_addr_t end;
> +	} *pos, *new, *next_range;
> +	int size, prot = IOMMU_READ | IOMMU_WRITE;
> +	struct iommu_resv_region *region;
> +	const __be32 *maps, *end;
> +	struct list_head *prev;
> +	phys_addr_t next = 0;
> +	LIST_HEAD(ranges);
> +
> +	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
> +	if (!maps)
> +		return;
> +
> +	end = maps + size / sizeof(__be32);
> +
> +	while (maps < end) {
> +		phys_addr_t iova, iova_end;
> +		resource_size_t length;
> +
> +		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
> +		if (!maps) {
> +			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
> +				dev->of_node);
> +			goto exit;
> +		}
> +
> +		if (!length)
> +			continue;
> +
> +		iova_end = iova + length - 1;
> +
> +		if (iova_end < iova) {
> +			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
> +				dev->of_node);
> +			goto exit;
> +		}
> +
> +		prev = &ranges;
> +		list_for_each_entry(pos, &ranges, node) {
> +			if (pos->start > iova)
> +				break;
> +			prev = &pos->node;
> +		}
> +
> +		new = kmalloc_obj(*new);
> +		if (!new)
> +			goto exit;
> +
> +		new->start = iova;
> +		new->end = iova_end;
> +		list_add(&new->node, prev);
> +	}
> +
> +	if (list_empty(&ranges))
> +		return;
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		prot |= IOMMU_CACHE;
> +
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		if (pos->start > next) {
> +			region = iommu_alloc_resv_region(next, pos->start - next, prot,
> +							 IOMMU_RESV_RESERVED, GFP_KERNEL);
> +			if (region)
> +				list_add_tail(&region->list, list);

Why keep looping here after allocation failure?

> +		}
> +
> +		if (pos->end >= PHYS_ADDR_MAX - 1)
> +			goto exit;
> +
> +		if (pos->end >= next)
> +			next = pos->end + 1;
> +
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +
> +	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next,
> +					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
> +	if (region)
> +		list_add_tail(&region->list, list);
> +
> +exit:
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +}
> +
>   /**
>    * of_iommu_get_resv_regions - reserved region driver helper for device tree
>    * @dev: device for which to get reserved regions
> @@ -262,5 +367,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   			}
>   		}
>   	}
> +
> +	of_iommu_derive_resv_regions(dev, list);
>   }
>   EXPORT_SYMBOL(of_iommu_get_resv_regions);
> 

-- 
Best Regards,
Yijie

