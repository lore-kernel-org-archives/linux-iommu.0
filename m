Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE31A316E
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769118; cv=none; b=Q6R7CkWqq3B93593MOUoYspYN0uEC6AeiK9lH9PlHgCngYuEFNdDOcKaJ58g0beEhfzCtEeySNJ6QfhZNW/MYirxNObRkOYY3wItfJTSAIzw2TNs8KYhTN6sJFKqYjJUrW8mnL4YF28Pb7bUJTwgwaGHfhDzXOeygGetX5fiVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769118; c=relaxed/simple;
	bh=qyIgkIWEPVtK3bvaf33iUXx+Lwkh8VwskyaNpGQA3FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUZb9KisXukf5W1OS+QTcZWkn7XEEuvTshN+mBxVi6falVNjZkbPDXBuEPcuHGouwXRixBbhZzARvmAShWxCCu9TMjM95q6bmyY7JAtEgcFHKORkzFCea44AIpckWzRiVFvbT98EQ7b7BI+KxOWTy8dqDfJ+m86LP7J1uG/J7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iwjw1day; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iwjw1day"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b22624bcdaso304287785a.3
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763769115; x=1764373915; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNFKsTnzS74A3YnRADAbN00lA3dVz8Z4Yjm0idBCQ+0=;
        b=iwjw1daym4o0z+vxBzmo/qb4Gj5CL0zviuOwN6lXLazjzbBytjEZ+DJCous2+iT5P5
         2oPCQljIIBLH0YbSyrQViCrGuFDjPpiLLOW8a8WAcTPkTqOlCC9W5VdQqg9jvs2J//e8
         q4pNV/xBpe6RmIEeBRyrxFgWnwXVNiSUmDhqc9l8TuKkBpE3YX6iPaRgpgC3hW978qXO
         hEo++oi5I37/VTaEX9MmmTPSj3bjvZzyvnRhptygBwRick72u4IQjK8q5qoTV1xkoimc
         lWUTceeGAX1sh2gztThhjjTfKYrC1MeRSUVPVuCLyK9vnRBZzSMcDWZ9HnJuSZyZcQpn
         t5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763769115; x=1764373915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNFKsTnzS74A3YnRADAbN00lA3dVz8Z4Yjm0idBCQ+0=;
        b=C9XdyXU1eENk5AeND5urxja+/u6BNt+bdfHtwA+U1uFO1jAR9o1DurkOifyXlwV81F
         fAPhQwCk8j7jVEclKp2tsSlSMhgLqctJeT7uS1LnY3Fb1qTnDt6LBhUiWH/tRiy6vMF4
         rSyxQiWxAZyem5VLT5xJ2xdKOIakf97QA0G3UB4Qxb9TwkLcdpssvpHnX0ApBM0m6dWZ
         b9PcGwCWD1o3e+nxeEGL746e/lFku8bN2vcstMjKpbAZFyJiDMJEFw+oMBfL/hipIqqt
         svu07o83m2+XjWb1XjDh01syN8TSDfpL0UqUQ6rqXySoKdkPaPjYdh+lFPu/rNL+YsxE
         glLg==
X-Forwarded-Encrypted: i=1; AJvYcCVT9vFaMOMidoQwItuCie9FkH6QaEzCPNF2j2jK5DPIabNtZHb7duM3MrnOPT38ehRqn76ZPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4iMCtlrLkXpLAu5fzHytJvOYLFLPbfWWf2p8B55BqE6Kk2XM7
	dXL/TuktOsrfEWH1OENmMPhZAJnj2bcjXyNsKkcSJ28wbKrbynLt/egDnyWotKJi2SQ=
X-Gm-Gg: ASbGncuZMmOpJKe/WchnPdk6BxoPpaffqluAapu2+xgEoV5fEjOFByiNTTavQoEeDws
	lEVe3GJ31ABi1dMVqHv4zgnSzfLhpqKea4gqNKrL4r1Es9PbfwcgLnZKD3vlDtUBmbms7Q+jYOk
	Jx7VtbJ9lvfswWCgZFmo3y4GGQ38G7V4AwASfAPEvatzBjH+RffRFUglFKiZe1ry/AGFwaw6A9T
	2Nao9WGDswg7o48mEiv4LpD/0wvgBcBmkSZB5EzpWEzE591d3cgtlQN7Mw4YbyWkqIUWbDmpwz4
	Ik46u84yV6jZAEBgYAlnqT51++SrR0vKQnh/ZA0F1a7LRpE/JeaaWdO4IRtKdmFzYdmh3etTLOK
	8WnfY2c1ZZ147wJeeC8QBm2iLcwCc84gLPd5jXeR6DGYsdxkiL7kAO+/Bl46WIm9PdeXlWZJlvY
	eYJQIalTvy1Xr/9huu7YvQ0SR1Q/8h6UvOprVdsFKWpqVN1dzBSeXt6UF2
X-Google-Smtp-Source: AGHT+IFWPATCeCmWOiB88Xr2ysxytHvAaGgMnVOpuF76dOClmpd6DtTQfeYA8jncK9mJHMi6OC8ekA==
X-Received: by 2002:a05:620a:470d:b0:8b2:e666:713 with SMTP id af79cd13be357-8b33d476f8cmr539235785a.42.1763769115207;
        Fri, 21 Nov 2025 15:51:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db543sm457101985a.38.2025.11.21.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:51:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMauv-00000001bzu-1Ue0;
	Fri, 21 Nov 2025 19:51:53 -0400
Date: Fri, 21 Nov 2025 19:51:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/iommu: Fix array-bounds warning in get_hw_info
Message-ID: <20251121235153.GK233636@ziepe.ca>
References: <20251113200854.429515-2-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113200854.429515-2-nirbhay.lkd@gmail.com>

On Fri, Nov 14, 2025 at 01:38:55AM +0530, Nirbhay Sharma wrote:
> GCC warns about potential out-of-bounds access when the test provides
> a buffer smaller than struct iommu_test_hw_info:
> 
> iommufd_utils.h:817:37: warning: array subscript 'struct
> iommu_test_hw_info[0]' is partly outside array bounds of 'struct
> iommu_test_hw_info_buffer_smaller[1]'
> [-Warray-bounds=]
>   817 |                         assert(!info->flags);
>       |                                 ~~~~^~~~~~~
> 
> The warning occurs because 'info' is cast to a pointer to the full
> 8-byte struct at the top of the function, but the buffer_smaller test
> case passes only a 4-byte buffer. While the code correctly checks
> data_len before accessing each field, GCC's flow analysis with inlining
> doesn't recognize that the size check protects the access.
> 
> Fix this by accessing fields through appropriately-typed pointers that
> match the actual field sizes (__u32), declared only after the bounds
> check. This makes the relationship between the size check and memory
> access explicit to the compiler.
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 9f472c20c190..37c1b994008c 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -770,7 +770,6 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
>  				 void *data, size_t data_len,
>  				 uint32_t *capabilities, uint8_t *max_pasid)
>  {
> -	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
>  	struct iommu_hw_info cmd = {
>  		.size = sizeof(cmd),
>  		.dev_id = device_id,
> @@ -810,11 +809,19 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
>  		}
>  	}
>  
> -	if (info) {
> -		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
> -			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
> -		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
> -			assert(!info->flags);
> +	if (data) {
> +		if (data_len >= offsetofend(struct iommu_test_hw_info,
> +					    test_reg)) {
> +			__u32 *test_reg = (__u32 *)data + 1;

This seems too obfuscated, can't we keep the struct somehow and still
remove the warning?

I also feel like you have a compiler bug here, if gcc has inlined
enough to know the size of data then it surely should know the
constant value of data_len?

Failing that, how about just change the caller, maybe like this:

--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -760,6 +760,7 @@ TEST_F(iommufd_ioas, get_hw_info)
        } buffer_larger;
        struct iommu_test_hw_info_buffer_smaller {
                __u32 flags;
+               struct iommu_test_hw_info dummy;
        } buffer_smaller;
 
        if (self->device_id) {
@@ -791,9 +792,11 @@ TEST_F(iommufd_ioas, get_hw_info)
                 * Provide a user_buffer with size smaller than the exact size to check if
                 * the fields within the size range still gets updated.
                 */
-               test_cmd_get_hw_info(self->device_id,
-                                    IOMMU_HW_INFO_TYPE_DEFAULT,
-                                    &buffer_smaller, sizeof(buffer_smaller));
+               test_cmd_get_hw_info(
+                       self->device_id, IOMMU_HW_INFO_TYPE_DEFAULT,
+                       &buffer_smaller,
+                       offsetofend(struct iommu_test_hw_info_buffer_smaller,
+                                   flags));
                test_cmd_get_hw_info_pasid(self->device_id, &max_pasid);
                ASSERT_EQ(0, max_pasid);
                if (variant->pasid_capable) {

Jason
