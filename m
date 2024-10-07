Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C71D1E89
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312155; cv=none; b=fxjXWB/Vn3aT7EgVjM5Sqc7P6riXOTPwVUzItVv7Nv1iibCvqCS9LwpRs6JhvGuoY8Th2VF0HFTJis7XKQv0MqIAtwh+gOsB7xd7b49XMqXj8iWV2QQxN83jGL+xZfjwTecsqDAH7S5nn2hDbRb71ZxVDXus+0gf5ZuvfAu5NpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312155; c=relaxed/simple;
	bh=D5kVbpKzUhQvMtWTZRZg9zhd9Je1CQMs6r/pautCquw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=kVT0l9Nqdu9gTMc8+O8gxQwq8UTP26GT3UjCh4eXXczno6a90YdTYSnM5ScS+Pn5oB9uWzfKytAPVH8gAlZ7SOPNVF7tw+sh70kwec2rV7sD5s3mkDS/aQtDJBgTitpzXRwxxmccxJ/6y6R2v7gXb5d2a1itc/L3pYmjg6Iq6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz195ljb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz195ljb"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5399041167cso6923576e87.0
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312152; x=1728916952; darn=lists.linux.dev;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OG0U1jbBXC/7HilBWvE9sxBBHqzXaiJZGz0KVtp1OY=;
        b=Tz195ljbW3gOSlnu0iFBjbRM56ir968I+kJ1YW5pEPmdeDJzok62/w7lloPHBWeP4y
         0XkJN2/g4P6xKidz6VRVdsn5iIoehc3vLT4hWPtfvUrdkaEWKhBFsRrda1Bme9OcQ6XU
         f1jhFEX4Bwy7+Rfv0BE8JV3/z89Haj3D786W2ux/lCy/61XNxBo9CivcRe0s2sB+oAo3
         //mA9NDp51GnbhiRf0eGRuCGN6GwAv92JBoQFjQsk/1WLWesCMGOkymuxBkSckvR60Ke
         6fDcGKxTmFHWaR1D+X3wDZCnPCJHroDgiMKV3UJ3gMjjeh5qZj9sbceXPw48t8yeHu0h
         yOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312152; x=1728916952;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5OG0U1jbBXC/7HilBWvE9sxBBHqzXaiJZGz0KVtp1OY=;
        b=Th2mgyhUG8z0GkVJgFTDWZy1NgS0g4uwjZDb2xWGPpGX94gLSbjPcXDIt+WXJN868H
         qiUUKI7wgcvlvNhZbNkvQxQNysWS1Oy0TRm8xAC14smgsBfAsVNjty6zPw1TxUl6bqGZ
         tB9j1grr4VB7RcZdMRMW9zMF/ojGo4TQtMiQwNpI2D5/ycx9QhaO4uOKnwE/623Or0ml
         lBmecXZxRiIe6n9kq5dp/KGNPHKNxC0eWxXZAfa08t9bVEH69pWhqFu8bqjJl+7REioC
         M3P6a4C2pgDNjcGIMCC6sO8d/DbQljrKZc2bHmYMowyLIalCbUmHM0pO1sZ+Z/SEWY/q
         IQMA==
X-Forwarded-Encrypted: i=1; AJvYcCU0wfPsP5/BddMMzJoG+BimFbDGxUcImMi+g6eN5QIvX353f34KCg0b78n+EZJ2eepaefSYnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzChhrS2kgar93xVOtY7vK7oknlfXvF5gL1b5tooPZ41tgDlKUj
	9WhAilZAJgr3PSjfIZt4SMTBgqSUGX460fBiTGCJlg2lH+RggrCk
X-Google-Smtp-Source: AGHT+IGztI27Tmigl5KSZUpChAclReVjTvDqzmCe6NGfCs6+JNfloCcqixsHuiDwKgpyiigf26s/Rw==
X-Received: by 2002:a05:6512:138d:b0:533:4497:9f29 with SMTP id 2adb3069b0e04-539ab87dd29mr7436136e87.31.1728312151890;
        Mon, 07 Oct 2024 07:42:31 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9949a37f79sm240442766b.44.2024.10.07.07.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:42:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------DOSrrXCulbNPxmqX14qrO8oc"
Message-ID: <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
Date: Mon, 7 Oct 2024 16:42:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20241007041353.4756-3-suravee.suthikulpanit@amd.com>

This is a multi-part message in MIME format.
--------------DOSrrXCulbNPxmqX14qrO8oc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7. 10. 24 06:13, Suravee Suthikulpanit wrote:

> +
>   /****************************************************************************
>    *
>    * Helper functions
>    *
>    ****************************************************************************/
>   
> +static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	do {
> +		old.data128[1] = ptr->data128[1];
> +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
> +		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
> +	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));

Please note that try_cmpxchg inherently updates &old.data128[1] above on 
failure. There is no need to update value again in the loop.

Please also note that the value from ptr->data128[1] should be read 
using READ_ONCE() to prevent compiler from merging, refetching or 
reordering the read. Currently, there is no READ_ONCE() implemented for 
__int128, so something like the attached patch should be used.

Based on the above, the loop should be rewritten as:

	old.data128[1] = READ_ONCE(ptr->data128[1]);
	do {
		new->data[2] &= ~DTE_DATA2_INTR_MASK;
		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
new->data128[1]));

> +}
> +
> +static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	/*
> +	 * Need to preserve DTE[96:106], which can be set by information in IVRS table.
> +	 * See set_dev_entry_from_acpi().
> +	 */
> +	new->data[1] |= ptr->data[1] & DTE_FLAG_MASK;
> +
> +	do {
> +		old.data128[0] = ptr->data128[0];
> +	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));

And this one as:

	old.data128[0] = READ_ONCE(ptr->data128[0]);
	do {
	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], 
new->data128[0]));

Best regards,
Uros.
--------------DOSrrXCulbNPxmqX14qrO8oc
Content-Type: text/plain; charset=UTF-8; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcndvbmNlLmggYi9pbmNsdWRlL2Fz
bS1nZW5lcmljL3J3b25jZS5oCmluZGV4IDhkMGE2MjgwZTk4Mi4uOGJmOTQyYWQ1ZWYzIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL3J3b25jZS5oCisrKyBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvcndvbmNlLmgKQEAgLTMzLDcgKzMzLDcgQEAKICAqIChlLmcuIGEgdmly
dHVhbCBhZGRyZXNzKSBhbmQgYSBzdHJvbmcgcHJldmFpbGluZyB3aW5kLgogICovCiAjZGVm
aW5lIGNvbXBpbGV0aW1lX2Fzc2VydF9yd29uY2VfdHlwZSh0KQkJCQkJXAotCWNvbXBpbGV0
aW1lX2Fzc2VydChfX25hdGl2ZV93b3JkKHQpIHx8IHNpemVvZih0KSA9PSBzaXplb2YobG9u
ZyBsb25nKSwJXAorCWNvbXBpbGV0aW1lX2Fzc2VydChfX25hdGl2ZV93b3JkKHQpIHx8IHNp
emVvZih0KSA9PSBzaXplb2YoX19kd29yZF90eXBlKSwgXAogCQkiVW5zdXBwb3J0ZWQgYWNj
ZXNzIHNpemUgZm9yIHtSRUFELFdSSVRFfV9PTkNFKCkuIikKIAogLyoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvY29tcGls
ZXJfdHlwZXMuaAppbmRleCA5NGI4ZmVkZmIwNzcuLjg2MTVlOTFmNDhmZCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCisrKyBiL2luY2x1ZGUvbGludXgv
Y29tcGlsZXJfdHlwZXMuaApAQCAtNDY5LDYgKzQ2OSwxMiBAQCBzdHJ1Y3QgZnRyYWNlX2xp
a2VseV9kYXRhIHsKIAkJdW5zaWduZWQgdHlwZToJKHVuc2lnbmVkIHR5cGUpMCwJCQlcCiAJ
CXNpZ25lZCB0eXBlOgkoc2lnbmVkIHR5cGUpMAogCisjaWZkZWYgX19TSVpFT0ZfSU5UMTI4
X18KKyNkZWZpbmUgX19kd29yZF90eXBlIF9faW50MTI4CisjZWxzZQorI2RlZmluZSBfX2R3
b3JkX3R5cGUgbG9uZyBsb25nCisjZW5kaWYKKwogI2RlZmluZSBfX3VucXVhbF9zY2FsYXJf
dHlwZW9mKHgpIHR5cGVvZigJCQkJXAogCQlfR2VuZXJpYygoeCksCQkJCQkJXAogCQkJIGNo
YXI6CShjaGFyKTAsCQkJCVwKQEAgLTQ3Niw3ICs0ODIsNyBAQCBzdHJ1Y3QgZnRyYWNlX2xp
a2VseV9kYXRhIHsKIAkJCSBfX3NjYWxhcl90eXBlX3RvX2V4cHJfY2FzZXMoc2hvcnQpLAkJ
XAogCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhpbnQpLAkJXAogCQkJIF9fc2Nh
bGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhsb25nKSwJCVwKLQkJCSBfX3NjYWxhcl90eXBlX3Rv
X2V4cHJfY2FzZXMobG9uZyBsb25nKSwJXAorCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9j
YXNlcyhfX2R3b3JkX3R5cGUpLAlcCiAJCQkgZGVmYXVsdDogKHgpKSkKIAogLyogSXMgdGhp
cyB0eXBlIGEgbmF0aXZlIHdvcmQgc2l6ZSAtLSB1c2VmdWwgZm9yIGF0b21pYyBvcGVyYXRp
b25zICovCg==

--------------DOSrrXCulbNPxmqX14qrO8oc--
