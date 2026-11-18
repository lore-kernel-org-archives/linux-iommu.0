Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004898;
	b=qKhC1PUhx84q8M4wFM/4XttwppiKIMd0eVsurWFUh27Wsf2UkKN232QsIfJQx2nZHBfw
	 z5xrVmrquCnewAYNPbgbo8C6lWFknkUxOvaOfZcIfNYX294+vkKqdHyXiq5HPmpdhWG6D
	 ooLg8sWtJ5YCJmueDSqqp9yKXdrhBpZoJuHduDEu2RvesjfuFllWpJEjQY4S2Jp42JyRp
	 wobYcwdZjE4wIm1WUhGK9dJLcH56yinQ3hUWFXoQy/w8u1D81Gd7Zlp2mh0Ayf3RkqTJg
	 QZAapQ9kUScRwRrOzNr9FyL48I7g6FqhVellt3oEz2QNCBoKfR9WgmlqteW2dXbZWRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Sbg0KLhjP6VImCPLy3d1+inU/8Bcn6/seY59UQYwN7I=;
	b=IyqgGgWZBBRZWouVhGKK8+izItTtbxEtoa1OzkNjvflxo54lGSMBsGaaVNpkxaKnwtPz
	 MAyoWO/cF1WjIZhuQnbr0md2zZ70Shl/cCvNkPXcm1aQEFVW0geutFAqydeqAFBnh/4dN
	 DbdfFMkV7ObZ7SshdSXuU3rGVvK23da3TnMHDdhYnU5SCOO3+uzT/25R7HeocZB86PY2M
	 x6evuBnE658BPP8//gy36mjFkBorxy6dF6YOrTwcJQvr79qD+2ccsp/oHXTAcF9CywLsX
	 f570RTc7D0XBTgd0LUrpHwcbJQ204pbVzWafHGUzazbaB24k2FXe4OJ0QIRsGURqmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OJEeAviq;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4F606A320
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC4F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=OJEeAviq
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so7656455e9.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004896; x=1795609696; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sbg0KLhjP6VImCPLy3d1+inU/8Bcn6/seY59UQYwN7I=;
        b=OJEeAviqy+HxK47wFBySbqOcDAAIw7h8kyaLK7Zlp/V2oqZ74vNZUgLxv81lxhgLQL
         4zfkCrBMj5sKPmIRQ1PNcxDRBLVcd6Pv2Vp16GQ0s+K1BqFLpGoRTfnaHwyAWc2LiDoN
         qSS+eEr3TO0ENts30BO/A12WWFOk2e45aj9TF3SuegKV1FSJPnduxuuHFkcrlnQkWeJo
         ADhcB3Mhj4pqhEt/TKhN0JDo/r0l57iaTbrEMJGlPOf/i3VWdajvJmx6eh2PJz3V/0i7
         gPTZO4Y6DMvvC6xltr5vHRc5t3RbxtqwTi6MhnonzJXnWz1ed4nvDjdVr6bHVKnlrJg8
         5sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004896; x=1795609696;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sbg0KLhjP6VImCPLy3d1+inU/8Bcn6/seY59UQYwN7I=;
        b=1TxU5RYB1SkvCL/X1Ul2rWitKol2+8qNdXlDP8t0L0/oog+YlV3+aT9jISHGOEn0Vp
         5E0pUu5PWzLOH5t1Xb6cH3XtTvvR8HA/jHt/R/38DQ+nxPcAsFb60B8EvM2gZeD1H6iE
         vapnqDfmKEVx9r0LW6I1XzTV4rvYcybgjRFMeDAVbtumEjkH57xtpqRk8p0yNoaA01k0
         K2Vo6xmAVlBkxYUYXZKZ2h0MzlAk2qMdGCCtqSGJtwO4k+AJiFSSNKu3YNK0V00niwk/
         KM+/kUjLNYApQUYVRVhWsalW0Z9HR506mhAjuSMF6A/hDFJ6WxFoOz78cO+RcvFY0an2
         x0iQ==
X-Forwarded-Encrypted: i=1; AL+hErEeuETNEyi/gj13ITK+KzONXEl6o/ck+dEmOD+Q4ilN9OBZvFAdRiZV7beWcnIU07UedJAQSw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9kXxq8ebEqJJGxzOqpvs7LmkiulajmeAUxwDHpaYeHyaCIv+Yt
	GTdsqMizVW9K7hySHJevXEfqvk9UEMAnCMHfW5peOT9SsIDlqmjKJLV2eSIMdvDK9pA=
X-Gm-Gg: AYBFou3vUdNrHwHt3v1mGCt/nudJgwy0C0h83V6sTvZk/KS2uIBFpCpas9zoq/2k6pb
	KNy/s1CzNPcW9oYQL9kewZrifsQfu6PGRcl3RoPAKVFHPVh0qh5WSX+V5WsnUFSv9uAEVVyejc9
	G6nKELzxAm9vYbKh4pB8jNkvFA0tICv5FTC0He/RlJUhuGmuKaLUuESCYOQHmZq1gGu0RPCRa79
	kDmu4is47QuITVTtxrVFp+G/dGJiaBZjhPV9/6GcKymR6F4MhxaVzJ3T0lFOJpXs+mxcz49OOxH
	2/WL8JG4TWBrQdOS6JE9DTFu4Q41PN2L03mAYZkez3fbDWesCZASO/3ZSzjnkBez5OLhTPzWNVX
	5hPCAdPe0aH/J8MmXmEr+L/9u2UQ/R2EADS48zqLOc60hpcWLTAZ+k3GjZBb5knLPOyc6iTwxW5
	bcAlBsSByvUc+0vw7s5VMLfGqX94IQ15J1aQ7+2Yzuye25hrZqIUOGQxTAorWp7gmvPWZn4yEud
	pIaKNIE1I2+FOeMFo8/EfCoqmWKRdf3O9/xjuYekKAoRPV/J3pPZIUi/bthafpz0C2oQhsD0i0i
	KMJVnavJI8ljbrXY/GLMYqQ9BgjnpB8LF3BRhyXhO+aPKsEGFCEr7clPX27dQKdcg2I7qJhZ1BU
	26A==
X-Received: by 2002:a05:600c:8b63:b0:4bb:6871:8f21 with SMTP id 5b1f17b1804b1-4bb7da27fd2mr44906275e9.23.1795004896063;
        Wed, 18 Nov 2026 04:28:16 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2abfc4sm64858355e9.7.2026.11.18.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:28:15 -0800 (PST)
Message-ID: <6291be5c-94e8-4a5b-aa30-f797672e4165@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:13 +0000
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
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 10/12] accel/rocket: add a GET_PARAM ioctl for the
 hardware version
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <bd963b70e40af3c3c74ac1569cda7be885b0ada1.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <bd963b70e40af3c3c74ac1569cda7be885b0ada1.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can query the NPU
> hardware version and pick the matching hardware description, such as the
> SRAM configuration and the register layout.
> 
> Add DRM_ROCKET_PARAM_HW_VERSION, which returns a hardware version enum
> that matches the device tree compatible.
> 
> The enum starts at 1 and 0 is not used:
> 
>   RK3588: 1
>   RK3576: 2

I wonder if REG_PC_VERSION / REG_PC_VERSION_NUM could be used instead of
creating our own numbering scheme?

> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
> index ef7043046bc6..50c8b05bd394 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -41,6 +41,7 @@ struct rocket_soc_data {
>  	unsigned int num_clks;
>  	unsigned int num_resets;
>  	bool task_con_16bit;
> +	u32 hw_version;
>  };


If we're adding hw_version here then perhaps the task_con register
selection could be made based on the hw_version field value. Then we
don't need an extra flag.

> +static int
> +rocket_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +	struct rocket_device *rdev = to_rocket_device(dev);
> +	struct drm_rocket_get_param *args = data;
> +	const struct rocket_soc_data *soc;
> +
> +	if (args->reserved != 0) {
> +		drm_dbg(dev, "Reserved field in drm_rocket_get_param struct should be 0.\n");
> +		return -EINVAL;
> +	}
> +
> +	soc = READ_ONCE(rdev->cores[0].soc);

Does it make sense to do READ_ONCE if the variable was not written with
WRITE_ONCE?

If my quick read of commits like 89c2c777df17 is correct, it's possible
that there are gaps anywhere in the cores[] list; please double check if
it's safe to always assume core 0 exists.

> +/**
> + * enum drm_rocket_param - parameters for DRM_IOCTL_ROCKET_GET_PARAM
> + * @DRM_ROCKET_PARAM_HW_VERSION: an enum drm_rocket_hw_version value.
> + */
> +enum drm_rocket_param {
> +	DRM_ROCKET_PARAM_HW_VERSION = 0,
> +};
> +
> +/**
> + * enum drm_rocket_hw_version - the NPU, one value per DT compatible
> + * @DRM_ROCKET_HW_RK3588: "rockchip,rk3588-rknn-core"
> + * @DRM_ROCKET_HW_RK3576: "rockchip,rk3576-rknn-core"
> + */

Let's not document these as a match against compatible and their values,
just state it as a way of identifying the NPU chipset.
