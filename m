Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998516D4FA
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722936; cv=none; b=s7ltD1W39TGsFDVG6+8dOAnS/A9mWbdn5It84eIHw19myKnflWKbiG1A8tpjjBCFCbjSxjmz02EYFxCqZxIkV/Yp8bJLBZseg61hl7kMknD+l/3vv+wWUEky3SNsNHs++/z5cwPlyVkrCtpsPEUu8jHqa8JjujSpcOyIjw+nwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722936; c=relaxed/simple;
	bh=uUEBl50imPAoSsJuo51Jz0jFjpZj4QP5BzBIY3rhcMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WcW7TfSp/cwDtboGM4r7CTXfHsawHZBO00Ju3yt1Rv6MlXUXgbApJFI02VkeljvxMi0LxDq8ofgrPfTxtipUjhuejoHWo+ve8HMC79ievlNLZRjAY6XCIhBdcM3Xt4tMafCbnxOSMynKGr3mFiDftwHOcB4HmAjRflkkv4QqNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmhdYlFp; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmhdYlFp"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c47ad996d0so652310eaf.0
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720722933; x=1721327733; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRGuEcfgu/j698HdY/jYUUZrTYugxC1Eg6T+lNNI9mk=;
        b=FmhdYlFp4VvIVjO79vhQL7I64WS819wPEzcYLb+VZzpgytge+XbDSdOQd0LYmZ4VHA
         CHTjDW/ftHHRKwAGav9/0+1aWZReF0ian07s9gdB3bUPRGOHCViSrPMuqp+czYLvvtAK
         tkTeQbFxuniZEeovnMEXpPWgZX1OTHbDMYy9DQ7dgxgyYJw4aAEKTAgy+sP72lOnn8IB
         faGTEEraWZ3LwNV4VmVUS0nozXGRO6WGI0WwCc3qIngI5RCoQtmrAkF6ZNCzDDRXvbSp
         jx7obMUGfaO8Q61FCFR+9HcLNKwTU+NmRfyxC1NT2Zoa5nlqGmPuz7KTAVR0WaT4C2rC
         5HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722933; x=1721327733;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRGuEcfgu/j698HdY/jYUUZrTYugxC1Eg6T+lNNI9mk=;
        b=aWCKRkXwlEoNBlwuycGapDsuHceAlUdz/yOoIcaSy2l7KLFzLLMfba1BM042jzKoOz
         tVeqZ0KusAqwXDUBpD0u7aJGgMrxr9xtVxTODOnvl1tbsQN/dD3ql7x3dLNmSDFoPFQE
         Vf6v5UNDka2lyyNH4LdKoK3Uepidr3hfUpGWuIvSag9PiB1tNJiw+Nme2JNoSV0hHrWg
         x7hiUiwK2vwbfMYo80zbxbvNYeTFpV3rqGa8dy9AwLPrHc72yxwLXS0ef90JWIDrezOA
         DTweZ4UL5mlnIZ3fNC/MLHZ5R9yU4hgO4pYdEGrLujI0usTaAKMujoeenaWg8l2Mw3YE
         IG5w==
X-Gm-Message-State: AOJu0Yzo0sAoo8a4hNc7JTko9oO0xi6vVo7QGdG0ldkFgA8ye7ndgPiJ
	ARN1DeNah6fF1kFOZdyMXNRB91/+U1pJuWxt8ske2rufhkbsLinSmcRJgq/UQi3EIZcIrjZWOYZ
	w
X-Google-Smtp-Source: AGHT+IGO3RpElQSXth/TmCyheaL3J8JIolRfsIlV9RcoXE6CL99c+tHVxp4umFrPfIQ2x6YbNJ7Nwg==
X-Received: by 2002:a4a:edc3:0:b0:5cb:bf1a:73db with SMTP id 006d021491bc7-5cbbf1a7432mr2811949eaf.8.1720722933500;
        Thu, 11 Jul 2024 11:35:33 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8f4d:7dee:36d4:6208])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c68cd8763bsm964419eaf.11.2024.07.11.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:35:32 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:35:30 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lu Baolu,

Commit b7d8833677ba ("iommufd: Fault-capable hwpt
attach/detach/replace") from Jul 2, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
	warn: 'handle' is an error pointer or valid

drivers/iommu/iommufd/fault.c
   125  static struct iommufd_attach_handle *
   126  iommufd_device_get_attach_handle(struct iommufd_device *idev)
   127  {
   128          struct iommu_attach_handle *handle;
   129  
   130          handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
   131          if (!handle)

This should be if (IS_ERR(handle)) return NULL;

   132                  return NULL;
   133  
   134          return to_iommufd_handle(handle);
   135  }
   136  
   137  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
   138                                       struct iommufd_device *idev)
   139  {
   140          struct iommufd_attach_handle *handle;
   141  
   142          handle = iommufd_device_get_attach_handle(idev);

Do we need to check for NULL here as well?

   143          iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
   144          iommufd_auto_response_faults(hwpt, handle);
   145          iommufd_fault_iopf_disable(idev);
   146          kfree(handle);
   147  }

regards,
dan carpenter
