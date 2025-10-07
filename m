Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BC246BA8
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872514; cv=none; b=gaNLIYLfA3x2glWiprNRj/UsrW9dETOiq+ICNEoQYUplI61OOMsfXFjQSauwSc1LXpuwBI9NfULSFZzaSNBwqKxE+v5spGZ3k6/8WTNaoYuniG5ZNJDzI02ZcIw9BEuXWnimBIiFQESzuRMidwKbvfhyQ9mTB5qzq2pxp9HuhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872514; c=relaxed/simple;
	bh=ybSy4Tv5iFVM78XbJXlpVrFeVjI9pBLjjyVsYoM1g0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9h3WW0lnmHzDacaPBa+hKuiynbEjZUoSv/UgBPA/cYIUSswQ55XXOSwVsh0DPVHDNqUtTCnXhsH9BRWM6UKYqvcnzaH+0jGuFke7eTRl8tW6V2hYjEVwDWyLzzsz1znrpN35p1tgC3Q1KV+sAxfMKBdhP807YAVcQfrwS5MKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHy3JtGm; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHy3JtGm"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42f61004750so23066285ab.2
        for <iommu@lists.linux.dev>; Tue, 07 Oct 2025 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759872511; x=1760477311; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=hHy3JtGmUTWO5n/IzClSSh5XFXtI7hv9Rizn2Y8/dFk4dqBTbwJIfKU4YQqOMtH+EL
         AjpgnPNLDVz36ub/cx4RD4/GMNXKY5aGikzj573yfEIfGFBtm0qmWaIQfXAQG/TsxXB1
         GEWYFz05dfPS5+FlEhGqa900oRwchkqXnb3gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872511; x=1760477311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=kpAL+T38XZnEgtWMiYNt/hGXzWHZa7aloeF0a00BnVN/DJK6CjIsWW6ZT5DRlgi5xO
         AU+nOVfGMoSwGstZUM4l+G+2bmtSUBz4l6BdVrPs2hC0L+vPEzIuc6wB9rzbddquUt0/
         iQiqlpH//duZ7cxITg4nioBFBr1VXgx9u3pmHx03os12tpAgP56XuRCOlfdkB/5Zb2AF
         QiJya9cI/B4nDkB5mUQRbNCg+n/pWDuimNyFs4s3uBwAK4gd9uE3Mck9oybCPgSc8UxQ
         FyVz0LWGXxhLHrUOQ1BCIfIfWIo9Xw06R0sKtPFXjlM5uZltMOcjXaTRwkbnTZVilgdW
         nYww==
X-Gm-Message-State: AOJu0YyKa8/7oCkY4SJJKRdLOLtCQEw+S4Abgpw+cTHKhzHYUy97Ipgl
	lC0ESS3Fh/gCJG/HGpNxuEQF2Clq8GpwxpA84hqmK3ykr7PM5xG4kr01ThQ0LV2W/BA=
X-Gm-Gg: ASbGncst6KTQpC6fcw34+TQtWIOJFN9hJ8O/Yxn58wfr8EMC6DDiOztUOhguzzoGZWw
	9+6NpV5cwVA5JpVDwiK9ZybI0ouUFrtfJKzLpXLprw2P6VrWtixfeO2ajGU4hc6R7+nL/tBBVjp
	7nsm7GDVZdBBLqW+skVgH+Cglrh2pRnfCeP6801sZo4r4kXkEQLXpVj9EKeZGbdCqpcsNIarP2S
	HEhoD8oAOPHvACIgU7JAjwxjrT3DQhbOyAlBEbz049VmloCrXLx/sSO53SgL90D6UZJt9pcb63u
	O0/HqCSbXyYuQzNiG0nlj6EmRhZpXkg5kjzcMQlCKEtPAGoh7kgFs8OHw3Lwq7YT1i8VFdg0eal
	9dvEV83IE6BXoHHoVtRvkPliy6HL+//SYaZu5uyy2qth+IQryFjDwZj7VqyY=
X-Google-Smtp-Source: AGHT+IHeHTgxlltTMg2jkQR8M4ckc7kuuLQqcNCSqE/YdELv/3ZHWfkOaY8nRgco+jsklhYgevWYbA==
X-Received: by 2002:a05:6e02:18cc:b0:425:8744:de7d with SMTP id e9e14a558f8ab-42f87419a6amr8445705ab.30.1759872511151;
        Tue, 07 Oct 2025 14:28:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b294f91sm67698345ab.34.2025.10.07.14.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:28:30 -0700 (PDT)
Message-ID: <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
Date: Tue, 7 Oct 2025 15:28:29 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, jgg@ziepe.ca,
 kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 10:57, Alessandro Zanni wrote:

Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.

ret not res?

You can simplify the shortlog "Fix ret unitialized warning" perhaps.


> It solves the following warning:

Fix the following warning.

> In function ‘iommufd_viommu_vdevice_alloc’,
>    inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>    760 |   if (!(__exp _t __seen)) { \
>        |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>    513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>        |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>   1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>        |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>   2924 |   test_cmd_trigger_vevents(dev_id, 3);
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 3c3e08b8c90e..772ca1db6e59 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>   			.dev_id = dev_id,
>   		},
>   	};
> -	int ret;
>   
>   	while (nvevents--) {
> -		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -			    &trigger_vevent_cmd);
> -		if (ret < 0)
> +		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +			    &trigger_vevent_cmd))
>   			return -1;
>   	}
> -	return ret;

Hmm. with this change -1 is returned instead of ret

> +	return 0;
>   }
>   
>   #define test_cmd_trigger_vevents(dev_id, nvevents) \

thanks,
-- Shuah

