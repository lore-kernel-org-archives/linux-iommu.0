Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB921D3F3
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641882; cv=none; b=WMKN4iYCaB1hjldC2vgWQxETAAJR5czk0xxY7KQaz/aJrMZfrhhbW841/j94CbVSXux9caCqColkD1Pw8CJBOYTjo54RpuZsi6zo+KuoIaKsC7baANThD5x0cZmKzXFisn1Evh2td7If7b87UuYrjB33ZHwX2+cJXbxOk+rKEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641882; c=relaxed/simple;
	bh=cHWMRWpmElbbxnsvIVo4IfwpJwGptDDbWvG2sPBEoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaT1AbK04u4acm+O/dUC1wvdzce6Xp8KasqcczPgjAhdf7u7/O193uNS2AOBnz8TZBe0+956D5H9aF7LjyTBCiQFL0K4LgIcuv9aYXJi5esjdjnToUeH6zv4fqRiDzLAO+Vl0DruDLPkR1oBd/1lL7nfoqMvDpdYAnXX/GgL3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LSEnORMK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LSEnORMK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFUnpp004473
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufAuzNOrEuaR7kWSPEsTig4aXq8QsxU007pyQbw/68U=; b=LSEnORMK6xSFBWBG
	WM96ZYe4AaIQpeGZOk2Er49cK60h4Jtp3xJir7zOjbnBWy/pK5c19aIPLng9oAsh
	/tD+Vp91woA1wlD8w/rjgRiDi3+uCUoS2t6X4oW+Vm0Nc1Y/+pA6W/NhLo7V5hyc
	3+3xsoMpLWCX572zLyw0ns0fzwN2KfZ1AlNj4gA2vYCD13CUMESeLBBjlah8z0al
	HwBh0XW4zSjbmBLQp9u7UTD/7HfNcW8Q8t71VV6XYfWAtFfAe0bENnvRXyS4xnio
	hbPYkKHvodJ2LlG8V2xMNAIkaXAdVJSK5WJ/UW5YxtvVZGPu5cKxcYuT7uyeXyI3
	9NUVTQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnsfpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:37:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso8585266a91.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 08:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641878; x=1759246678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufAuzNOrEuaR7kWSPEsTig4aXq8QsxU007pyQbw/68U=;
        b=Gx79GrbMudZSXCg3cliTlDwr+Hqh5V33EhQyyvuRqfLkb+ZBAFnKpa81zvyQ+6YgwE
         c1+sHoaUQlsKbo6Oe5GbXDPLwvUrXwiiozJHHxs62snea/V3wFC6jFno+si08WNnUuUV
         G2t0mj80nubH8W2XYWoVlAcjlnW3XMtTJm/0BFO3z/tZKeGBm0gnIg88w0ORP4f34rqo
         TjCmdWCeYQoyMCllbQoqclJ7MswQ/qserNB3cTAu/Ut6v4LADCQD19r4cxchQqb4Df+b
         SO9ul5pOrjWAD1OWgwRmWVGe3OjAFjs5bnCeOz+uEzWLZqZcaevCKWgod0mGJ0SUZne8
         PVsg==
X-Forwarded-Encrypted: i=1; AJvYcCU2tOJXIld0n9rJpm6VRJ3YIL/Vlyf4FzBldlQB0sebiJ3NpVXXsJiccxJ6DVRgckeGv/N4Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7vBlLpQorY7UZHlyiCiL1vXYkIjPV3OPZXq9z8MmgAj4+KsIi
	BX+eGHHYdWKtmaZ7E2x4R30Ubg9A/dXcTP+xFCbW3ZAGOA2d2PsUGotdYkw0lZbOQl20b5esU4t
	McdqQHIP9WfUTn7X26ugA2GuGTBGM7S1p6cJyuWbVrMwj+zTq+eGgwpbxtg==
X-Gm-Gg: ASbGncuiD9mRzkJrwyMEaxgH4/BZYvH0Y/I9yDbpO0igetPpn9/o1zA/XZqmouk2133
	sPL247xK4HQI6n21UCDK1pu2MNFbpolwpok3ygiiTPf5SBeXU6OWecQOUAerxCyW+24tVYfQ+tr
	LnR+uNsLGSBDcaJVF4mrrveGABrDb5LA5QC+QDDnyjmSpkHwMHBu2kj/mfZm2Y1Z4pZP4FQKWuv
	eH/RttVIDxrwiZoEZm9ZH1HAXU6gEsNMTTO1IFGx5c4M2DQJ4mX18nLiNGrteZAFvxNXb7Ho3ie
	WJUYuFj6bQkRVNNABosot0c7VwtaRx+/1nJq/w4sN8fbveC7YUt0bw==
X-Received: by 2002:a17:90a:e184:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-332a95df91emr3380125a91.27.1758641878003;
        Tue, 23 Sep 2025 08:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ5jbKJKVF1FDLY8GLviHNw6cT/lbR2hSnQ4OQG1i2UHqwyS4SLyWKqPX7QqT4IcM9uxiqXQ==
X-Received: by 2002:a17:90a:e184:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-332a95df91emr3380091a91.27.1758641877466;
        Tue, 23 Sep 2025 08:37:57 -0700 (PDT)
Received: from work ([120.60.54.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5526a9af62sm10960133a12.44.2025.09.23.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:37:56 -0700 (PDT)
Date: Tue, 23 Sep 2025 21:07:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918141102.GO1326709@ziepe.ca>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d2bed7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=0rnFkIpAFraqCr9DAfvGIQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=X2H1Dzq6MFM7WdPJhOEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: d6In0qlhxhdZ49zsADpIoBlc_Ws1ZNW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX3cwnzORu+hIi
 edfrklM6Q1Vmh3/3ADtVRSHT2yPiAS7YsPgvEAZh+F++LhY7zy4/PGlHyutmHHg/i/HwsYw6xG2
 YPWifLQp5OvOYGF6om61FGmTe+J5uokhd59ZLPX5o/4p0kf/0S8oGBPsybe4yZReTuqetiCbk2z
 07+w89SRpM+XvL5eiPsjYPbafNm5Oxm2D9Pp84kyIfNHXoufPWO6IvIL7XPQ/r/+yMmirSqSxJu
 5yId8gQSKPFGqTRvWxtREmC35nP913XebpSSyH+jCbb28xTpoUx5zUx3oemUMVB9nn/vizWZ/GZ
 vtxfbDtRlVGQJuu67yUa/EH/HRaBLVUrgHbd3UtROWuWoJiO5IDWbMLqaR8rOGq7iRZrhtQWkZg
 Q5oSIigN
X-Proofpoint-GUID: d6In0qlhxhdZ49zsADpIoBlc_Ws1ZNW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > This issue was already found and addressed with a quirk for a different device
> > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> 
> This is a pretty broken device! I'm not sure this fix is good enough
> though.
> 
> For instance if you reset a downstream device it should loose its RID
> and then the config cycles waiting for reset to complete will trigger SV
> and reset will fail?
> 

No. Resetting the Ethernet controller connected to the switch downstream port
doesn't fail and we could see that the reset succeeds.

Maybe the bus number was still captured by the device.

> Maybe a better answer is to say these switches don't support SV and
> prevent the kernel from enabling it in the first place?
> 

I'm not sure though, as Windows seem to be running fine just with this erratum,
without disabling SV.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
