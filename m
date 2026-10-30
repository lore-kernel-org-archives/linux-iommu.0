Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362128;
	b=ReoIWGgRYtWl1tBxIkqlgdFa6Vo8qWOAmuiEyvo3agbRKA7HFiwmmOkZz3rVnHKHVpAa
	 3f3ojvczur1nOQTcHipFskhCISDMp7adRydL3MKkSPOsahLpr/utWZ6cXor+C+OAlrzOO
	 ZhuxlTodv0dxqrcdrahpsX2JoRPsnBlWWkB9J+r83dkX8DS5SC55iipBc+2QJ0Nsqk4rf
	 PmQkXD/e39iXlWxXR7QBBSq1PiCWVfAY/C+bKtVwZgkc9TCV0Oeg+1IEM4EqyT/LYC34R
	 /W+TwhgAx/66t5zfh3S6A4tTy4FkYT6Cmbjiy5oVrBommburETQGtfxgObx/TMgZd+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RRyBEpiuIAokrfRrdR0N3udD7wd3mhkcqcx+n5TQKaw=;
	b=Hh0/C94WkYt9gkvOP9OdjMkfN3yU576PfavcubrXSFa8mEULYOkDUPusfFuDGaWfLrhd
	 m7iWi2HRTK/JVsQ88hB7zNHIugmuNuuMEpPDOqKBppXotpW8ew2hyi0JOVffRBpNuWvRA
	 TUeuWRvsAW0CzoqfPI5vOXzqtrFfQgKGbn8PgO/lPRfftiTvCRHTZI0QtRqyHyZN7gVyb
	 7nqRQbYplVx2x4KnSPE5HTTyij/0QRm8rIW1ypTTYbwjsBNwqNpf/jdkdYB4WV4m4vrhG
	 mBpMPk8ivCyqPhGriuT2iGAZcpKAjox1xk+CzIxtvdbJCKRQirhSbOIIdTTxP2whFRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RHhu993G;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD8606A31D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10DD8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RHhu993G
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f560af6aeso77433685a.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793362127; x=1793966927; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRyBEpiuIAokrfRrdR0N3udD7wd3mhkcqcx+n5TQKaw=;
        b=RHhu993GHaL7pb6wWaBT5tPpLqvwNIC/orYEuGmoqIxtTb+2YcQmcLc1wZU3QwMP4W
         9paTsDPdzd83pwiPjuxsVMyXffYu3Jw0A1rRQ8HOeueQwfdearitrUiPxqT0LtVJxdyt
         K1uC7U7t0wX4HN1hzmkaf4W/ZRMlWKrv7jTc8X1zgkOu9ORpdDZQ6KX48f1XpClSfP0R
         5TPvOSLk54ZfoDKwlfTi9nEoLirGcorap8owm5JdxrDR+T0m2FxQ+Js88UiFEpGKS4BD
         AiU7tNRnhYueYa73xjqehy2DOD/54IJNIuuOPjF9QVW8IpKV3Xs16ag5oG77cJkOKYgi
         QYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362127; x=1793966927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRyBEpiuIAokrfRrdR0N3udD7wd3mhkcqcx+n5TQKaw=;
        b=Rpk5E2nUTKxoGdbjHJ79MT+9VoMrqbigT/wl79rPcLJobjx4wIKLEi+dzrI7bSuMho
         SQxFkD/hJE4HFqD74+DpzvTW6iAkk5MnVZdFr2L+8pmkmlKTNKN3/ipFNa7xq6T7hcyb
         A2E9KG88SXodgdY2j/QENVNZoOzW748Im+wxmHNtR8kq/qSqQA8aHZC5XVwtF1OXEDWI
         U8g1LYyx2jQK1NM9wg91ZaaiVE3HeRXsabV0nc9OpmJPY0mwahQPTCbsbkHsVBFyZptL
         NhiYSosQ2Ty2gpnHtdMzMoq7cYrEYei5M/yg/e5ghdK3fzyA3HCZKTZnzh4i7pX+uqPO
         6/iw==
X-Gm-Message-State: AFq9FYLHW0QiQeejz441vfC2n3rJH+truIBKfZZtCP170wDetOzEBIyu
	ySYuom7qyoKxaEzcGAVYwK5/IYAO7lE7BYLtti7ol9HZrlDNwqlqKdZhBSa79UNpGFQ=
X-Gm-Gg: AYBFou1BWrkn2cbYKJpY3fEYIzZrUoRQ/mVKeyOhVgUCx0SoP2j4K9SB3N/Ti/Jxvpd
	NEeckdW2K749693wPnb2tgDqIr0rTZll4hVP1hJUvd0aOaDsULOKSELylK8E1Pwzjf/G5DVHZFe
	RLkfPG8QNpO1ME7bhXqx822EDi3LxjOBNoh7fj02t9zmDggHvd/CR/kwI2eFqpSYbtLF2WPKWCT
	l9nsQm9JZ3iJ4bUZcd0B2gOTYoDX4aF5O/wIAcfgQSrsBDvmekxMNvrTArQMOcXIVNcLx8KQJok
	XcqDV232oNr4Fl3wD8jOVkHq/R6JfEYC587faONgspiDk4Bkj305bQa3qHzEc6O87XEH5WZP5AC
	P4xG1ev7tIn9fm/xvn6LvWWAy4ZBdGrfUnfGHHfuQVouPepol/glyDeOJRJX93PE8AhwRObABJ5
	iYXXkjG3R5yccXq7WoENd8QCR4lCsnbTlI0Cly6ZYa2ODOemMDa4xE3hHt90csUunwVfozAXywf
	W4RrNj2t2GLudjZzQt4SUl0ZxnqJEM/yDbfNK/9pplAyoBrci7zI7+OxTuBZUvymfuEixBJqqzW
	58t6j3LgyJXYv2tGnJX4sjPSauKUDFLiu5n7UrKI51LXg9EntvdYLjb0FR2UJsf8qikftvLBCjL
	ay6LRvj9FMWc=
X-Received: by 2002:a05:620a:3703:b0:93f:3120:6c84 with SMTP id af79cd13be357-9442173fc02mr343438285a.36.1793362126885;
        Fri, 30 Oct 2026 05:08:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425a6b9b4sm126316885a.26.2026.10.30.05.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:08:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMlPZ-00000000ZCc-062F;
	Fri, 30 Oct 2026 09:08:45 -0300
Date: Fri, 30 Oct 2026 09:08:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kyle Zeng <kylebot@openai.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] iommufd: Reject opens until module initialization
 succeeds
Message-ID: <20261030120845.GA3889730@ziepe.ca>
References: <20261030042345.74537-1-kylebot@openai.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030042345.74537-1-kylebot@openai.com>

On Thu, Oct 29, 2026 at 09:23:45PM -0700, Kyle Zeng wrote:
> iommufd_init() publishes /dev/iommu before registering the optional
> /dev/vfio/vfio compatibility node and running the optional self-test
> initialization. Either later operation can fail. Since file operations
> can acquire a reference to a COMING module, an already-open file can
> survive the failed initialization and refer to freed iommufd module
> memory.

What? This seems like a core bug not iommufd.

files take refcounts on their modules when they open via this:

static const struct file_operations iommufd_fops = {
	.owner = THIS_MODULE,

If the module hasn't even loaded yet I would rather expect the core
code to not allow the module refcount to be taken, and if it somehow
succeeds then it shouldn't allow the module to get yanked out from
under it.

It is hard to guess what crashes to be more specific, but
at least misc_deregister() is safe while files are open.

Though I wonder how module auto loading works..

Jason
