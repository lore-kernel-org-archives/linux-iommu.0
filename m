Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62544194A6B
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327638; cv=none; b=i5X7tsAiUFQGVN3fUuHVCCfQD6aBESrImog8ZSS7iaIXDQSXSUa+o3reDZH92abOXPkHBT25nFEruFBtbuBZ7GrB923vOtCqmVrr2OOxiNTrD4OmX8b5n/0aTAGXXdbfo1ASRKK3TZB3FXXzLTgQbwP+MCDO5IvIAYlsxz1Dbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327638; c=relaxed/simple;
	bh=T0BhJ8aGPqjNBm5SICXuuUnA5yiEuzVLZoEd9Aw6Apo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gJj7UAL+zY+pwqfJ05v40BPEJEV2t+MUyuRoPPROsoxKRMs0Lgj/IjPJ/ZxD/3Yk7/wUQWkjYLqevSnn62j/CvUDMJ3fwawf+J830pos54YY3EH3yy3KrL18YTLpd6yBcK93DOqw9YhXqOe9a/3HKJax4AvajO9oeFt3/RP47JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUcZTPEy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUcZTPEy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso163600295e9.0
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736327635; x=1736932435; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3vSW9iDX1W4ph12mI82UpJ9kLVfGCXSCw73OSMj/2w=;
        b=XUcZTPEyouOmlzW13Ctqa+2T2IEdrUeWn8gSqUbcpTxv55/E+biAAN8BYTzlo2UWlc
         ZRzoZWypLvCsNs6bBxy/xQZfR87hUtdrHqA++UHdqoKWlGr9RpgNg+BA6Dn+vzPtWQCi
         7KoOrTZuz3E/EUCXx3Sk6m8oJYUyJfyk+TKxJEu4EYxXWhw+qrUQTdz0yWuhesVLcjLz
         zDaMmwT82s17LE2d3L3Vg1o6PVUdenBHuEOeojbunqpsBwI+BOW4WiJxJ83ChbFp2ZG7
         EHB+2y85WDTfldrVfg5Cmx/mcRJBQlX72GjML/NZKBC9eUJGnYKvfUBmUD4fl0HKAhG+
         nW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736327635; x=1736932435;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3vSW9iDX1W4ph12mI82UpJ9kLVfGCXSCw73OSMj/2w=;
        b=RLJUz9s9Om5FHnHDrjmyx8DU7ntBVo6SAlUTHM9Y1FA/EIJqvY6mfyQf+w7IfK+jEa
         VeTg0cOksJRKR/p7I4U/f9Nlpbz81HIPhtL0oCOHTssb7TBPLUx18UUJi04hfDCqZr39
         rRG643gCJXuhcWstH0yuekyEEm98ztkJ7c2yJL9Bg6rD1vHCf2Sc39RSsk0EYdqIoKy1
         coQpCFDccgLL5a/y8UMJ75Ee1lmvS/DBZKww6DgD9rUHZHerfMC87VZ9uyIid+CYauNL
         Cf65ZOQBquMOWdNAy3hdn9DUROeDbs52JJKDdOor1ACm+vTYq+NAx+9980eq2+sz5/nT
         CKkA==
X-Gm-Message-State: AOJu0YxD7UzTf02HxSEzwnd6Cr9QJIc02Spk3UoR8jEbueZ3qJqhjkc9
	wOeYubZdD9g5QxGEMeH9UAaN9U1aDVOV0ofeKmKBInsSuet5lFmuGaww6DvHnRI7KKihYAg6pjV
	r
X-Gm-Gg: ASbGncs212XjS2T3zHGOfv5tBlGgTgeIy1w9FhEe2iYuOGkKuutfCwGgjv0j+EkztWe
	GRBrH7v/SyZV0XCsCGLgPbS/lJzruC7GBnjaqDc8jwblq4yI8+Ssrhl8XC0VkDoEnu+0Z2F6sL/
	Ov4J0eDKeyKWBSHf72S2tGi3o+EmEXjVLmm/ashj2rPrOvuajTYAyiP9KJSAuZb8iO54oNe94Tz
	Hzi9NoZBgunNK6KHkvFpNw1Lk3kkoE6dYlL4+rzegSsujJ6SOyRd0UKVjOU3w==
X-Google-Smtp-Source: AGHT+IGXdgKi8LaGz0z428TQZD067PknF1W9zJoDKDslc1Hb2+JDoRz3b8iJprspZwUPGlL9G1XMfA==
X-Received: by 2002:a05:6000:2a3:b0:385:efc7:932d with SMTP id ffacd0b85a97d-38a8730faafmr1343927f8f.46.1736327634718;
        Wed, 08 Jan 2025 01:13:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c6ad3e3sm54158721f8f.0.2025.01.08.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:13:54 -0800 (PST)
Date: Wed, 8 Jan 2025 12:13:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommufd: Do not UAF during iommufd_put_object()
Message-ID: <0ff36678-997e-4bf3-88e4-c3381bdf0b72@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jason Gunthorpe,

Commit 6f9c4d8c468c ("iommufd: Do not UAF during
iommufd_put_object()") from Nov 12, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/iommu/iommufd/main.c:192 iommufd_object_remove()
	error: we previously assumed 'obj' could be null (see line 160)

drivers/iommu/iommufd/main.c
    119 int iommufd_object_remove(struct iommufd_ctx *ictx,
    120                           struct iommufd_object *to_destroy, u32 id,
    121                           unsigned int flags)
    122 {
    123         struct iommufd_object *obj;
    124         XA_STATE(xas, &ictx->objects, id);
    125         bool zerod_shortterm = false;
    126         int ret;
    127 
    128         /*
    129          * The purpose of the shortterm_users is to ensure deterministic
    130          * destruction of objects used by external drivers and destroyed by this
    131          * function. Any temporary increment of the refcount must increment
    132          * shortterm_users, such as during ioctl execution.
    133          */
    134         if (flags & REMOVE_WAIT_SHORTTERM) {
    135                 ret = iommufd_object_dec_wait_shortterm(ictx, to_destroy);
    136                 if (ret) {
    137                         /*
    138                          * We have a bug. Put back the callers reference and
    139                          * defer cleaning this object until close.
    140                          */
    141                         refcount_dec(&to_destroy->users);
    142                         return ret;
    143                 }
    144                 zerod_shortterm = true;
    145         }
    146 
    147         xa_lock(&ictx->objects);
    148         obj = xas_load(&xas);
    149         if (to_destroy) {
    150                 /*
    151                  * If the caller is holding a ref on obj we put it here under
    152                  * the spinlock.
    153                  */
    154                 refcount_dec(&obj->users);
    155 
    156                 if (WARN_ON(obj != to_destroy)) {
    157                         ret = -ENOENT;
    158                         goto err_xa;
    159                 }
    160         } else if (xa_is_zero(obj) || !obj) {

obj can be NULL

    161                 ret = -ENOENT;
    162                 goto err_xa;
    163         }
    164 
    165         if (!refcount_dec_if_one(&obj->users)) {
    166                 ret = -EBUSY;
    167                 goto err_xa;
    168         }
    169 
    170         xas_store(&xas, NULL);
    171         if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
    172                 ictx->vfio_ioas = NULL;
    173         xa_unlock(&ictx->objects);
    174 
    175         /*
    176          * Since users is zero any positive users_shortterm must be racing
    177          * iommufd_put_object(), or we have a bug.
    178          */
    179         if (!zerod_shortterm) {
    180                 ret = iommufd_object_dec_wait_shortterm(ictx, obj);
    181                 if (WARN_ON(ret))
    182                         return ret;
    183         }
    184 
    185         iommufd_object_ops[obj->type].destroy(obj);
    186         kfree(obj);
    187         return 0;
    188 
    189 err_xa:
    190         if (zerod_shortterm) {
    191                 /* Restore the xarray owned reference */
--> 192                 refcount_set(&obj->shortterm_users, 1);
                                      ^^^^^
Dereferenced here.

    193         }
    194         xa_unlock(&ictx->objects);
    195 
    196         /* The returned object reference count is zero */
    197         return ret;
    198 }

regards,
dan carpenter
