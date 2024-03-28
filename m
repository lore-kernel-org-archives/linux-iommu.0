Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352212FB3B
	for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640362; cv=none; b=Ag9lflx5Pl1EED48HPeuej03GCL0dEck2NBRgtSqvVZZc6YQFYvXBb6bsdDjE99tVz5L+T7wZwdh4erH+Qx6UjPxXkkbhBytTRp9C5IYP8rs4dWWHpEirHTIpjzYmj6LBSlt1pXDsSp89XDxU3T+IGr+SZyapvR0XZWczYLv6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640362; c=relaxed/simple;
	bh=G1iRW2zHIY2/EiULrJ1nqfVUKDfTimjQj7b8q3dHoFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIDmEyNGI82Y+27KVdKTKAGTsHDr76NqBxPJggvlYBfMTX+F+VzS3H4RNmNaAfJOy/Zt3wtFfrUa7ZjoT9r3J8APpP7Y9jruUXR5OS63VFnjM7yxJio1o9AMmB/aM/XHPRbWtUW/XoI+uSNCN/a+sI4LSHYqxJgVeumNrq3j+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMd0u48U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMd0u48U"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so827746b3a.2
        for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711640358; x=1712245158; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPjQD/vT8EW8FIsS5EhEUvjw7Yq2DPw74odbleQjQC0=;
        b=mMd0u48UQvF2VIv2uh7L1OQcL2FZtSreRdhgUtjv4P9FxDPk8tDx4uten3xzZH38CK
         ClOsaEoqxM5/80ppGz++FSnrntKLw8BirlSgik/veMTXkC0Ose6YHPmP7S0zU7IPAYX4
         HX/w3xJBg2lzRNnpc4t5NT2zasn/XpAxQ1K9kNwm535Zzislom+Uz4YYJREjQbxqeQlA
         1409dR+S/kZ+hzZczS1yYWjsJXjdau+pBvLtuaCJdBxid9yt84ogyKBQhirYbx1Dio2Z
         KVYEzXyB4C/+yCRYDcApfPf34ERZBcsoG8f5TLKBZPLmR++wLJAWSOBFKywqaaB9KI4k
         mGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640358; x=1712245158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPjQD/vT8EW8FIsS5EhEUvjw7Yq2DPw74odbleQjQC0=;
        b=mFziShBmgjfbeOEDR6KEgSOx60nz7bGk4yowsMUINGjiHfYnOwAGgeTGtnNJTQla5B
         BXJE08VTCyaMzWJ8Xj56RvvIigOQFH8h6o/BMpV2fsQOevd6NPfDdRqkJiTxSH1DgShv
         93fV1Jf60ajWCSOvp/qvecjl+ycef3p5dVtRds2+X2H4c9plFZDSakELag3Wx9QM07m+
         IETE5H/7MeP/KO1KLmUmxlsGaK+rYSLcuWU/5S6tbM5sy+em/HM+4cFmqwW9wlHRLRqa
         Qzx7145azgiMHcJXsV7CIT4AAmT76JKBGlbdoNH4VQohqEqMPnPf1yS+qPLLdwhTUjqU
         /R4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPc1AdKVCSh3soU8vUbOqZ79mUkFeCYxEtwS3FEEDdZUS3ItTbfEbpadidEOtAxGLW3HzKTqTHzWKTHrV1qVPpao9ylw8=
X-Gm-Message-State: AOJu0YzpeuowZLMl2ODnD6I5q9+97fjlHSQKaynqMNazymgHJcE+XYND
	JKsh9Mwjyae40Z4R3pCpLgzMHvgKI5eBGbRr9MdATUEFNdfRYJ/1778R96SnYOc=
X-Google-Smtp-Source: AGHT+IGhUQYINGDQ7hWfiGCoXweY10vLCz/e/x+HjJ8dVvYs43ivIcKXZCgoqnZGIv+19J3DIwIpug==
X-Received: by 2002:a05:6a00:a12:b0:6ea:92a7:fb82 with SMTP id p18-20020a056a000a1200b006ea92a7fb82mr3800870pfh.27.1711640357806;
        Thu, 28 Mar 2024 08:39:17 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff63:c57b:4625:b68c])
        by smtp.gmail.com with ESMTPSA id e2-20020aa798c2000000b006ea923678a6sm1505830pfm.137.2024.03.28.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:39:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:39:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 19/22] rpmsg: virtio: drop owner assignment
Message-ID: <ZgWPHntosUk+5qac@p14s>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-19-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-module-owner-virtio-v1-19-0feffab77d99@linaro.org>

On Wed, Mar 27, 2024 at 01:41:12PM +0100, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 1062939c3264..e9e8c1f7829f 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -1053,7 +1053,6 @@ static struct virtio_driver virtio_ipc_driver = {
>  	.feature_table	= features,
>  	.feature_table_size = ARRAY_SIZE(features),
>  	.driver.name	= KBUILD_MODNAME,
> -	.driver.owner	= THIS_MODULE,
>  	.id_table	= id_table,
>  	.probe		= rpmsg_probe,
>  	.remove		= rpmsg_remove,

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> -- 
> 2.34.1
> 
