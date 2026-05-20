Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638F2D94B5
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293008; cv=none; b=P681N3Rf4MH6XmkwNW1NAlA8lyrgUgo3SK39D9/c1khAta/x5CYWiTX237Zt2GFU2c2v8MkfWsjVUrugW27D6U+Mh2ciX20Rai0TCtxtUkncgVooROhPfyLeet3uX2lDJp7tlBFoY5hAuW+Pt1p4NhYVNuKG8/u3/rblkjaLRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293008; c=relaxed/simple;
	bh=IcRNfO99rl3sMZAna09GufNUoyOZxCOeoNMfliN/qC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLaa054AXQBDIoPHHAc02cYeif0DWdCzJLuHu0LhoY6GAiBGICnnglrcndPbZXYngEhInrq8Ze269qwvoHVE63cpAm/CqEECGWT7c9s6dbzolNfMONY0oPlh7MjjQWLnZiSPdSTg5bBX8Q/OIZNjw+AT56X/8uai6R60xsMfWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=coOk3mEj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bSzg4+0U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="coOk3mEj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bSzg4+0U"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDXhiG1798400
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zA7pObzAMVJ588IBJt5ZdjHy
	sWlv5exY/p5KZLGwEaI=; b=coOk3mEjiLOVItEW+pPAt/2bIGLAkiLk2KUps3rK
	MnrH3SSw8Az/5hOsMGXJhk9nCQwDhLbp11FErLochf08cjSy2zrNyM7DGmdAcUIC
	HrKP2x8sTZChMIm06e835jU5+Sa05jGew6KSNoUhwjUI41vevsgJ2E9nbjHj/hC2
	etzQoKs+AgBEqVCCVLFNOeG2M+4UFiKZVog+BaN2MnQejtESS3IF1rje5QRq0uCH
	2PFpA2o0fUKHYeNVg5yXiad8ZbIKk9k8wR1kD4ovtBoqLLDwFG+bhPxX438LD59w
	JAlzSbPm/EAEVRCMDMHooD7PXHqSMRLP35Rdii9G5JtOuw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu0m7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:03:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-132d631edaaso32181740c88.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779293006; x=1779897806; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zA7pObzAMVJ588IBJt5ZdjHysWlv5exY/p5KZLGwEaI=;
        b=bSzg4+0UO8wrk9ZJSWPTvFgkjAROXHEJ3jpXv/tk+InyMmty1UgDjt6cro7IprBlyp
         1RYpLSTgKQzPADbXmv5uWzOnVhObzUtr+pOOaHEH3RfBowkq3soJG+oNQpj5RUBvL6A+
         K7gZ5vHvJM3LdJmFoVwWd9IdyNLKYfTv8PkQVrJM3u1D2dfb0NH2vgDoRS/M9qA1AGyU
         SUvX6HJgwg7gG5MnFQTki8zsDTaRMpC/NFvzmRAEcjHK9ddN9g4O9XrPnUusg9wRd3W3
         wqJzwNKMAfq7Dvicqc9Gl2KqRPwtW5CNxIduTneakpzB6EGv7HZi/EJCBnmsHcLFXzE5
         X4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293006; x=1779897806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA7pObzAMVJ588IBJt5ZdjHysWlv5exY/p5KZLGwEaI=;
        b=LEpXMy1yHKTCcqeOBT73BPFdygiMY8a6Lmh3U2qRCKpihwAmYV5xjo2VHMsyQ4QEDr
         nCxlg548+UOpQEzRSSLUJgHf+cY41TRJ5kO+TRexxHLU7CMa1yudSxsJj8KmsiQR9ojh
         uy+hNQRraBbNy0JZbvQBqkpUmfgdju2v6GYwFA56FQRBZPFobbceF4z9UCPWdiOlF0dA
         pMjB2ftNHqAYqO0aueBFhl7admlkKFLxCDVimFeIaacgjOiBVR+SwZ2plJaxVGvHKJkJ
         y3BUAA+VjvB7jxAkfmixtZoGvH6YAAyPiaman2P0vXYrfBN348+tFEDjb5P5omIC7d0c
         ad4g==
X-Forwarded-Encrypted: i=1; AFNElJ9w6fv5XGx9Gpby8AGIZafAuHXv4bCqscGmM5Nao0Bbz0MlmKRqOoJZrtOt9M3lFHUTa0GqyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaQGWGjGvnR2FsVrY0FKbgFUXbepiwWmDwMT4lOlpK/+k2n8GO
	XYO9DuUssu0m3xz/3qTCXkEyDF3kRmTGindUuNE46EFQKYt4/aHQk5jPVXoKFgWYDCSwFI9C3cX
	KK5UzSOy85ghAOKL0dt3ARn3TpAnwCVsBGC+66uYkd98wfST08Qm0F1QmAg==
X-Gm-Gg: Acq92OHjh7LE28MjTEEAuXemDl8ohY+I4akOS3CQ6mOc8QuNSh22Prlhgu5r2EVCg3z
	27y2/DAkSLEXb3tIRFMnmNYTnMj9XVAlEoISZGAzq9GFTaPWZhETK39rsSFHKujTrT1SVv1x/XW
	beiC5MRyS7+typyyl//gBgml7ZcRorjYTlfih3TZzIsHDwxcPfgeDZmc2qUUmaPIJPfAMIQ+0nd
	82x04eNety+PwDGviDLZqcStTqKD5CyoRb8A0dMmJhkitIHP0IpxkOOStXILgcH6ux0U8/9IBdK
	NoNKNHEQvSDYfY2QT9GsYxIy7tHMP6WuMyHk7vpPe0emHx4U2P7csp7Gt4XHYez+WR0Km8zLeS0
	Be7DSuMKYCTesjkGV21+aBZIkznfQ4vY=
X-Received: by 2002:a05:7022:ebc5:b0:128:cedb:33c6 with SMTP id a92af1059eb24-1350451e5f6mr11410029c88.16.1779293006184;
        Wed, 20 May 2026 09:03:26 -0700 (PDT)
X-Received: by 2002:a05:7022:ebc5:b0:128:cedb:33c6 with SMTP id a92af1059eb24-1350451e5f6mr11409883c88.16.1779293005176;
        Wed, 20 May 2026 09:03:25 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm27266669c88.0.2026.05.20.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:03:24 -0700 (PDT)
Date: Wed, 20 May 2026 11:03:23 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: robin.murphy@arm.com, ajones@ventanamicro.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, guoren@kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org,
        sunilvl@oss.qualcomm.com, tomasz.jeznach@linux.dev, will@kernel.org
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are
 described
Message-ID: <kkx6nqyc3evbfeutxkzwv6kbrotsbxopkvit2e2qh6hljicq5m@x4bb54loffkk>
References: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
 <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NSBTYWx0ZWRfX0IUKT0u3Yvn4
 1GV+oC5oCuLSmpdLhwT86z3hQuv+y30mHF+RTL9hVKaa7LPX93nwOqUlRnE14koUbSh2RBxvZg9
 Sw0Zsuh9N3ko2HB8x93KoWN2C3YuoHWGcN9skBRXWlRFmC+o1msfOQUfv/GwadsMdTGL21CR8a/
 jCLXLGCO2nlKUROLPY/7l4fDXsRsGNyp136rhQGqw5ygoCmvBYmvN3XZH/5g29+2xppXfvvh2c/
 67s2JbNz7j/rFROX9d9LE3IRnKgHKOuh0AE0m7s6Dez3zS4WPbJG3TeFVurqS3zwz+tuRRUse2b
 0iLFmyDOGcNYt0tR3EACjBE30LpECve7jJ3kVGwgoTDyXUrYEjJjzecJ0j//80xExKdIDdATXJD
 U+GPI0dshD66fWKLZbi3JEtO2lb/ZTzViE+iR+FGXZ8E3l89JIZmxJFWdkh/RNAKUfLxzzSgqlP
 PnBcmo6r7DsTwnQ95SQ==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0ddb4f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=SRrdq9N9AAAA:8 a=GUY1ysHpEHdUDnuj3zYA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: yL4M49Ct6oUw4fEzTHeVPbOFwuJYvN0w
X-Proofpoint-ORIG-GUID: yL4M49Ct6oUw4fEzTHeVPbOFwuJYvN0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200155

On Wed, May 20, 2026 at 09:44:16PM +0800, fangyu.yu@linux.alibaba.com wrote:
...
> >(As a side note, is there a reason this is calling of_msi_configure() on 
> >a platform device when of_platform_device_create_pdata() will have done 
> >that already?)
> 
> Good catch, agreed.
>

This is here for a device creation order issue. We have similar patterns
elsewhere, e.g. drivers/irqchip/irq-riscv-rpmi-sysmsi.c:268. When the
device is created the MSI controller may not yet have been probed, so
msi_domain will be NULL. The of_msi_configure() here ensures it gets a
second chance. Anup says he has a device driver framework solution to
avoid this pattern that he intends to post soon. I'll clean this up
after that.

Thanks,
drew
