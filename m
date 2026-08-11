Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370436B937
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453923; cv=none; b=YLh0jwchm6DI+ca/lFXwi+CLPzSSYIxXoT6mHJyPH5o+HTaFQOXAs7ZA8sasPi3zXj2+tFxN/TZuNfuwGR6ea4aB8Dv7pQhKivZ39rcrUiOJiMA7w3G4KTuCYNUl1Moxkd9awQS6a/sJ2CWQM++dGW7ZcO+WdJIv9pSwpMgyvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453923; c=relaxed/simple;
	bh=aM15LEyt+A7JAFcZbfqqyzVQoXdDaCRRtEKVlrRcLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4pDJEP5PEarZTs6YzZnaQgUb/NZmJ9FG22V8XkLEGZrzhpp93Xyhyizjtc8jy2xf2gp4Ov5Bs+PE00Ky83KVn6Yn8Fd68PiUrnLZ6ZQoDXpt5+Jr1tED6tb5cx8A8kG+Pc1+uttnA5hPB8B+USfFf6eAfM3zSb5EtULq0y70mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AkKGked2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AkKGked2"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-526f963372aso18517791cf.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786453920; x=1787058720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aM15LEyt+A7JAFcZbfqqyzVQoXdDaCRRtEKVlrRcLog=;
        b=AkKGked2XRKxd7iarjipyxjy9zBbjHvPZNBR4WjY/hMjMF/5IKOaL6y4T60vc69QQ6
         39GTT7GRBapTMBiFF/kCfqkfAqg2i5JpOjGJpbjQRJ8agjEaSF9K26Uln7YGTMyZXy8y
         Jmf8bU71D34llj7KyITUwGInYTEPC4zZ+5Tmfr/VleUPVruucr4JebGKKiZ776QAgaft
         Xqh7uAfQfrxfw2lCpnw2/0st3kbHDJkwRvQy/lm7HF8G51fkPrJqxq/e9CFqKjAlybsm
         /KOPU4fuaZa1sQZVv9//HZJWMnTVeuKTwJxl9cKlyRhLwGtFIa0a/JRcLyvwhS7haEpB
         3fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453920; x=1787058720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aM15LEyt+A7JAFcZbfqqyzVQoXdDaCRRtEKVlrRcLog=;
        b=aXLYAiYH9CJ+Po+W8OsDqvtcneOB1rMKXQc0UxM32BYOADpV9k3d5/BXg6Jt3O9zkP
         0LAViGmMsH9zfvOH7C+DTIR5ON7Cgg+qEEVRdPGwld78MP/XTGMJKdpLRToCkItZfmfV
         Xqe3WRhUR0INvklLgTLq8D0zDk5HFLHMtxbfsg947bt/gkpQ6MChXnMFPEF83nkas/Bj
         SlWjveS2/198aOoCehrIG/IxDVZzdbYxt1Um3jWv7dy8kjsuBlBRetdUqQBylgmpr1HT
         yuLu/yLrExLckcJNbjtqt8+9R7JPjL2ibthqXFRQPSOIQsvyCH0LtW87zcxSImYVGcs8
         MppQ==
X-Forwarded-Encrypted: i=1; AHgh+RroqI3KyTvScycspN7SMCQSkoGDlbipCpXMVPEr3xSqFGLKU3vJJacyn5ibYDFqZvIOKNVQug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZWNX4ZnHRlVYePMDO6ZUEdwWY4mE5xHQsTBf/okRAX9E6SziK
	4fu5enFhvyNqyIB62bLUgZYp30MH22x56P6/7Zl6xgoIG53uAtD8cTVkDmkydm5VVaLrkdbeLOC
	x4im4
X-Gm-Gg: AR+sD12vRpJdGXrb+bvB0LxxSNH6MOhjsz2Q1MOkyaLMiTCBT0dNLhYWmjaOnf+dDSd
	FYlamG+qocmnO/HmC9cVUaOvalC8w5ewpUDQrlwfoaY+CKIQGs4E/xsxiwhN5gFvbSNhYSArawR
	NECNKZS52+GfN7nuny2lxb+r7gNhlL8miLnYvQ0DrISb7zVHtXRCSSIF7xm9Kcg/GInghJzPDjY
	uMi6Pp5Kk8Po88SQ6e9vnm/KYbPHLgF2Wq2qyC0dpIt0tuqv1M9Sk5HtwcxS6uPTFnlekufDefX
	eEPPiLcmBqgVLHV7XS5nJhbtcHObX419OyWhmSMdoFd39rAjGWOwAEYZkUEc0tQobOlaT4Q0OUk
	YEpfu4rtIwhtaEYNikPxcEdAV85t7mjD1pNHDp7rpmWq2/TEjlJvMBlo+FZDlwEw9wpjkAAwU5Y
	xaQWGuSqxPECpU3FoUbLcxUQ2LYg0G4cPx2U5Htg==
X-Received: by 2002:ac8:7d53:0:b0:51c:9193:fd9e with SMTP id d75a77b69052e-52d58507bedmr24595901cf.15.1786453920333;
        Tue, 11 Aug 2026 06:12:00 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6646ee92sm9764246d6.8.2026.08.11.06.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:11:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtmGo-00000002TA5-3uJO;
	Tue, 11 Aug 2026 10:11:54 -0300
Date: Tue, 11 Aug 2026 10:11:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
Message-ID: <20260811131154.GA544626@ziepe.ca>
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
 <6f650cc2-b4fd-4305-b4d7-847ef935449a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f650cc2-b4fd-4305-b4d7-847ef935449a@arm.com>

On Tue, Aug 11, 2026 at 01:57:38PM +0100, Robin Murphy wrote:

> But where would that unmap be?

If the theory is right then the bug would be some concurrent driver
thread like a work queue/timer or a user thread going into a fops that
outlives the driver remove function. That thread would do the unmap.

This is an extremely common bug class in drivers at least..

eg DRM has lots of challenges in this area if the guess about VGA is
correct.

Regards,
Jason
