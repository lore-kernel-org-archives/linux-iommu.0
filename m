Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016F12B6C
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670836; cv=none; b=KjYLkcFzRI5TJyqJgod+36IR9El2tDm9Xe9K+N74qzTIL126LIqkkqZMv1tyVCnBWN3814IQB5XosSEwWbbSqkcup8N7IzEAPW2JhW7MvKE8tj/oWDWtiPwTYsgjLGvdPqxodOcGTaf1ofa4z1NESQah2JZNlaaoPYbBxI8W3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670836; c=relaxed/simple;
	bh=XaikJ0Vqxv5/owJt8g9Lm4uWIq8JbSQckm1iXMFhiCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRRUIumsSGIskvR8vTgpGDZ6mZ9npOITfL3XKqst9prCf56g1hmW9Gr5rOyEXl3/6LUypF7MNUK7dpK0dfds4kdJ1kQtR03HMrpmi6Qm9bk9Hh2X58+3ge2poNvFE0EVTDEFrPNvJAzeKkvDYhbv3hDJn847rRovL2nEQqiPB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/DJTrb4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/DJTrb4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4127190ad83so3449665e9.0
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708670833; x=1709275633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=V/DJTrb4v1sLF7RejP8D/+aBZNxjv7cawDLyrL6MNu9BtPoJbpfTtY1y7+YdI01Dz5
         va5KaYxkJEjfVw6M5PsemHxU1UTjrqisCUQJMkFlFn8V7EWR709N0VAUdc/5xPh3SGQz
         T9IIzRALGYfUIyhDnZyzmcUjmnp2/XmiRBx10ruyGE7Zvgz07nHolY4+qAJ972NLwz6P
         noKMKh57nrwCC1ZjK3EAB8eNoM1cPGIZB2zdY/WaKVynxBEG/dRJNl2SK56c4XIRPC2T
         6AM0ZTh2w2roRchxXMx+Xx/ky0RQpzOvX7HXZzR92f3VGwlO3sxeW44zmWmLkFoZFpEf
         yrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708670833; x=1709275633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=eXTd/nOAxza/5OIufBFsmiLLJejjIXMmDSprPW+NMmNbg9XX/Tflmgb7KUtSm8VUmv
         bYlUy75Q+FXYxYxnKZgBCh92nto6lcAO917sAwynz1XDGEICt9ftoTCstQKdpeCLsJTk
         4hu5JYtbFVK645xBDpiM9Z0eQ/NgETKdpKZdOMTDo4W2x/FHfRjoxMdss+feMk97zQf+
         faP4fgiNam7fjFOoXVx+UHEMzf9aAs+EgVphL2mzENnavZADBfVh5skUO1fwaEfUBJ5x
         ukje+RMY/DwN3X54J/kKaJ+JCDe0u5rhl1+lPfvPfmTdhaOUFqlkBQHv6GaP84QUk6cx
         KO2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+VfivV9VJ61P3MA1bJUPL9OUfd7hOJwqDBev7BuJR2OMucCRUzQne9gC4cBVFyJ/FEcqL86WSjV3DFBVn/2MwBu1exyI=
X-Gm-Message-State: AOJu0Yyo5RQUFz1XrL8B/0VowCB0BR3/fCag+OClMZxrytHvbOZHaoCy
	ZN6JikVhLC80HpPjLMIAwLDg4JNCYZiyi59s6hsTw7f6Ywqnwvca5KeVH2EXjCM=
X-Google-Smtp-Source: AGHT+IFa4F7JCo816qd08qJytnkaOEApdM3plMi+keu68PlvjipxHkYq76LVVneFPr/ZB9QKYJYcvQ==
X-Received: by 2002:a05:600c:1f10:b0:412:5a3a:7ff4 with SMTP id bd16-20020a05600c1f1000b004125a3a7ff4mr643537wmb.38.1708670833141;
        Thu, 22 Feb 2024 22:47:13 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040fdf5e6d40sm1162858wmo.20.2024.02.22.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:47:12 -0800 (PST)
Date: Fri, 23 Feb 2024 09:47:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
 <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>

I'm not a PCI maintainer, but first two patches seem good to me.  For
the third patch, my complaints were really minor.  Let's just add a
Fixes tag for sure, the rest is okay.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

