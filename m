Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571863;
	b=krYapARNVnmHsoV2B+i4QhPsJmosDXSKP63Ix5aOYDayykLfS5UUsq2CFKZ8CEKB3rYC
	 PyfkPLVTEPIqPsoh/6INTf956y4wXLBC5nroAs1wPbaotsCys4+Sjz3RI/NVTKtLAIY5w
	 JNCLjcURmXGzKyx+iaW5hGJkzpVsGrC5SxRu5X84AQXxql5JV1e5mPVif2XQBW4q+Spsv
	 hL3InBmpshxxs41mxqHeNZ6IGwoGJUGRseD7gldakzwX32Qy1HtADs8oMH6Jk6JMnrgUC
	 vtq5Q6UbN0MfVfPXkwVl9vAcpfiKEDnnMRgqNScAFtSmkc2VwsViTZR74m5MbwjFf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571863;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
	b=MCGfUiO2Deh2r2wvf5Ynz4Gkb+iiGPFG3X82+LxRFJYU7zavIC/59odVDv9vwM1i0UdW
	 CqkXOE+j9OvSVF/3SKa0v2pUI5As4I2/lkI6j34hHhLN9OWi8mxWBN+oP09CPehFpTGBr
	 bUl+aS2tReARRbtYfxzYXnCXOPR0Xk2UWM1cDpLEO7UVlnu3QQfajcuJCrTTh44MCZkq3
	 dB8g0uQnjHGIEPjaSF3J0CtJiZ8vQM9IFmPJEWoYYF3n6Wnpw62C7aC0NMgpRt9cP0b++
	 XlhoObNJrPQqwMGbiiuLzM8XTIAjQ4BfiB4U3WCSovS78yCH5lLeavCmA/CglrGrd8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEFiQ7Cg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ie9TzPzb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A8606A31C
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 418A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEFiQ7Cg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ie9TzPzb
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC0hYE525310
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=; b=TEFiQ7CgOeSRnQW/
	Se5AoZ7dU6cjjcaKCcUCdHvC6glfYOpUgtIi46FqA8lPXUVJgojFjfTr5Twfu4Mp
	CQbbN6g6pHf3PwdXgHahKEHyyYCJvFy3uK1ZrPlHyfhXCDZPXP7l2zI3/X6YRhr9
	P4cuWfILX/CScAZSIlXC+90djbPnxUYlMfurTNDWM2n9N5nRSr3Zm+vlX3pnFWhZ
	As8+Ov7kfmMtzFJB0joQo73uFu88E+LeiTT/JhxBaznhr2QHYE+waIvCpoMzvaU1
	mUm3VHg+zCXtMTkhyvJzq0nOEheAZ9Jegsrr/fM1r+Ndg83P6CJP2LKdzamirrDX
	+ZsSTg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0akmsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:11:02 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5cc87885c6eso42875e0c.2
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 04:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794571862; x=1795176662; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
        b=ie9TzPzbJlLCuB4j6fi16LxgON4SXa49ATeG7vDTHSw+K2Nmx0qhVRyRtJML6HD61T
         U1mMtYc473J2tEErYa1NkBQB0PH6GFFFwhS5npoymeutI637fEVcJf7oHKtJZGOkowT+
         KtspGdDeHBkNQZromANK2TNfwe0SN6ZgImXqnx1TQx/2tf7i6SopSnd+SmiWMfWzKklm
         psaKrdhjnkJckk+qXuzutx0qBZikP2hQ5mYeHNfhV9PLVo4YUOJfkMSuBnExSmucWNDk
         10EaK4+vcXHJbIsn1xgQfLNNd3yDRi0a3wkpwHosJbbIoeiRVYHVHIqVBO128ZuQRGfO
         Xfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571862; x=1795176662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
        b=RJtgn4aqU8hpc4d6NnFkLS1/xQdgECuKugv8b3YGcTbrhKdUsqlv5pxQN2YfTeYD20
         b0r0mFW7Hzw/4bhEzEPXn/GQ78mcqKVhhG3NQ2KvDAuvNxudH5krGumaSQKQcLuvccL9
         yeo0VfRBs6ZhinvEAxTeWRxSBL/ipE9kuAQ4zvxKd56Hp+w4Esg5jBppxall6ZJjxho8
         C6u9S7BCTitPQKwcNp5U+Emvx+/gkjeJewPbgg+Lto1KFKfm0KyfFth7eVO5A9W8A+Al
         f7NPLD+Agzw7EJqWsBj7S0CAxBsheKuptNjsv9SQERvbwiBFwV943+yz+Vd50L9gE0Yn
         tp9g==
X-Forwarded-Encrypted: i=1; AL+hErFxgnYB0erf0KSt01Tpq10NGqEX5wGv0ca79gKS1+9gYtEB/y4pbspBaxUY7j73I33th3Ny2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wwjr8ngJVpcYWw952nZrHgRzP0UeHWOMH+d5oL0Wxsumo5ZA9
	zBOdJ/SdV0Q79MqvsUTyGdOuMihTBGMNv0XXOK+8336H6YEyV2i3doncT2nSD9VnrPFNsutcybI
	R3rcS7ka4+IntvMl/wNKy2vkE40f9JM7Nxy0Bjn0RtJ5wNTC+XewD+opjsQ==
X-Gm-Gg: AYBFou0Fo1ijUNeWTNzaI2yXAR66NX87U+/khOTz+kuf7oFTQMzg+Y7i5UKdpjPojo8
	9NB3iYJ2kRCicouDTnTNU1P6Yo/TvfImriGT4OtZy9biZitWS6aasW9wG8SZO7/1G6vEh6rkRw1
	NbnkaoL7qWwwzaSrJEC//p9cMBpxcfl5wCKuL7HvGjc6cgtN1+mndgA3ZVZaXUEF5E5qeHPZJqA
	gEHZ7y2v/MBSqRnk0alLpODRUUjUZyT3DE+HgSRE/NicAtWL4cM1aOI5MQqYsq2+DWeEXPjq59I
	55NR58NBSOKqAGK4eCJrL0pbUvBLCiMitrBeuhpFK33FqODwGamKtK1AeN2aeWsvD0Fs237i/Jk
	js+H5xfvfDBB4B5BrWbCdPouhvXrCegneZzpgsjyMzrsfDdyoVHWtk5e0Nxgy7W1WedL/3o4=
X-Received: by 2002:a05:6122:6c09:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ee346b6663mr738713e0c.2.1794571861684;
        Fri, 13 Nov 2026 04:11:01 -0800 (PST)
X-Received: by 2002:a05:6122:6c09:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ee346b6663mr738699e0c.2.1794571861279;
        Fri, 13 Nov 2026 04:11:01 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm86814566b.47.2026.11.13.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:11:00 -0800 (PST)
Message-ID: <03d75b49-dea4-4736-a662-27ef64682157@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 13:10:53 +0100
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
Subject: Re: [PATCH 17/17] arm64: dts: qcom: Add Samsung Galaxy XR
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
 <20261109-halliday-dts-v1-17-289114ab8197@gmail.com>
 <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
 <20261109170407.2073295-1-lightofmysoul@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261109170407.2073295-1-lightofmysoul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX6f4xTPXSN5S7
 fshtK82X51lSRul9tB167GpSFhhfllsKbzzP6L42vpLHnwP8CRCtAC04Axt33hPvm/MFUckFySR
 Qnd2kg4s/YG2nMwn1f7SP6OYp0quPtY=
X-Proofpoint-GUID: 055bOieTYX5S8tRv2uPS4qY8gWVjXEr4
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af6fe56 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VS6XN_di3_qKZAQ5k78A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX6DOfGtJvdn3K
 oVQ5Us7q1HPjDMO79CONtGTykwUFeVH1hrOsqX6sNQadl1TPOqchEaCBIOGSdOn2qtLsh8TE3AR
 jXAPri09gBcURO63mcxuihrUUMgCaEwkU01x1ZfTOuBL3scpy0kukFTv+jBpYAIttJqp/jZ8RFV
 oYLESthDivHQK0XE6HrvDSLn4r/WWnN03q9fJDtXoMyYhozwdnhGrxnQSX8tonQG7F3qhfGL4vi
 mrHUr56RLicFOULrEsgLjlQcypcqNYPx+gyX17cWDQIjhcfmHo6HehqQTeBylkMwkV0Be2uhJ0h
 hI/sX0kfdZZBt1KXzYeaZxSUSc9SPkPRSYi9Dp6IstacYo6rQNW/2iE/Hz880YdsX5HXQg5jpYZ
 Ru+PvJlE/prBnHtUYpnufTxzcv5Gj0eADGyxklI6E9VyUKH701MMUVfMLDey2YseHlzOL1sSNyV
 xlT+uIRL9YwUnGnF6iw==
X-Proofpoint-ORIG-GUID: 055bOieTYX5S8tRv2uPS4qY8gWVjXEr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130048

On 11/9/26 6:04 PM, Stanislav Aleksandrov wrote:
> On 09/11/2026 16:12, Konrad Dybcio wrote:
>> On 11/9/26 1:33 AM, Stanislav Aleksandrov wrote:
>>> +&usb_1 {
>>> +	dr_mode = "peripheral";
>>> +	maximum-speed = "high-speed";
>>> +	qcom,select-utmi-as-pipe-clk;
>>
>> Is there no superspeed / dp altmode in hardware?
> 
> The headset supports USB SuperSpeed and DisplayPort via its USB Type-C
> port, I just haven't brought them up yet. It seems we need a new driver
> for the Type-C controller.

OK, we can do that incrememntally

Konrad
