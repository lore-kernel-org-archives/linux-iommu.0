Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259214E06F6
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352726; cv=none; b=hbg75lj6XLJ/H5vgvaFVUM/BlAni97q4Fx/eYXZt5xAhBYsJJey2zDtT9DgIGauZCIIq2jdvEUazBpannxn1zErymrZOh0dRFDhfSTaRDs6Gtz9+a6h5PWxKiJCC5vScoLeTgBtL7kVxSZKm52XyIg36rDWG3oilbOK7y32pXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352726; c=relaxed/simple;
	bh=Wfze54LtPMmI0xqKGIBHk5HpMn0us4cGASNlC9vZDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiquVDE3kcQAdDRS31lTYHfP/TLPBn3y7JiO94tLWni9Bo1oS43rlCry/eR5lFeYfJ/2BNdEkF6h57JrNcBdl6KPsLoh+RnTPmwmvOzUQbJ6iqwgnKR90lxc9Xw5LkXaWRkUyukc1e8qSjXr+5RG8vIgApou/+51oypf9Esmuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJiI9PPg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJiI9PPg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so6684495e9.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352722; x=1790957522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEfLZw+SZ9l3bCU1EQAdMa/xVIANZgIsiXamG4UPSuY=;
        b=UJiI9PPgpNGAbsEDpZJTjRbfhYszSRCWuIb3o+ytKCKg5KInB2nj1t9lZanCJPcRMY
         TEMWPKP3Sx9aC3cMCnkKUk/inpS0+PZa1h3w4UhVJKZbabtd5Wl4de9Xoz1frgMQFVCA
         7XgwcY/0COKwCinzfa+vLQSGD4Bb7wvhAUBXXnNVLoOT+13wtziXnx3UkSISx7awGTPH
         mobM1npKhyBnNYTtADmHYuxRPFzo9bSQ8qAYVMAxWoibEQ+x2MDe9qkAtUV3i5kir9KL
         K8Ftj36/kpdC2tv1cLmQ0cYISsjbcCwWgdQXu7gntijURswyaIxec1gi1CEi78KF70n+
         /x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352722; x=1790957522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEfLZw+SZ9l3bCU1EQAdMa/xVIANZgIsiXamG4UPSuY=;
        b=e2BKdPsLmiAyvWiJt2giPHHzjv0iHoo8QqHjblR21NSQMEmbm5YDSH4bOp4lexWzPx
         OmhhU4xkcL49ktSNybNvhtqXxKJUXPFukwsMxgsj1/Zm4w06Sx0isUHDpgbXB1d4G/rV
         vJfe5R8HD0FJ8t0gytef3tHfwr1ZZHt2W4Euot6H+jajtbJ/TdG0k66fFD5nyj7x6g8A
         WuC/WPgWDKHLYpftqhAtzo6zxZPkTmBaunP9/zIdbdhRV2F/TtUfjat1RyZ8pKi0bCaj
         RC1JpJo1trWxFgi5gICHi4OL0dXi0RQyCrrPBcD4Y51lOJhFslmp1HJY/N9YMloaLqz1
         8hbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKG5QMkqUX1fht21Gmw+Il9tGEtSNWoQz+Og/vJVAFKjkzHHjfQylXnQlvOG2k5GNeNN+i1w==@lists.linux.dev
X-Gm-Message-State: AFuF++k1LDs+SlLm9xWuYYHVEK6TRP3qihtQ+RWUqqkkUOR13Mu/IMQh
	Q4Lf04mHfDw8xsI3nq3FLTUn+sbTU1+G/I1dUf7+uDDhrh4BcatSiNgF
X-Gm-Gg: AYBFou3fdkLyQg7B/hfS1X2sJRntgRpjNrXZZI7ylOsZ9v8hC6pzwGibf0Zskcrg3AT
	sGAnT5Y0WvIfAKRq0FBEHRd4M/upUAh1hAMS/FC0Y5gVKC6rplmInEqhCw54qbOALgyqFi2FwKT
	q9crnMG93LJX/CozPyBFoITGiztL9iaTcHyC4KV4Wl5YLlcN8lhwOof36uAvDwGjH4EaRiWrmDU
	0hvnYWIG3x4CABe/zY4cRn8q/Pep53dhjGiwnMxkYD/hFXm4do8NcKkENU7aYqKIaOFcjBSxive
	F0ILhLf8mTEApaB+yeLuVtIPZn1XhPXNzfLgBQVlb7qCG07NuRcjH3PYXZkJEYVqueW3tTYfnw9
	trE0GzhRl4QN5Hly49CO9rLzyDhDmpgAGHr85+QiDhb3b/BtwU0LZp5xaWEpP4PIiyGWcxu7hom
	dPcmOWoNLK+NP9MaOTIqh6a5e3/zVi/kupW/nJV7NYm6yftt74y+pv9HNkQxGl/tuze0/DePAl0
	fBOvqqFE/c0QibF2ps5pU653jB1/X4ozbJnSO8+PjGx
X-Received: by 2002:a05:600c:8518:b0:49f:d325:9912 with SMTP id 5b1f17b1804b1-49ff06bcd79mr47529705e9.10.1790352721951;
        Fri, 25 Sep 2026 09:12:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:12:01 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] iommufd/iova_bitmap: Clip recorded ranges to the bitmap
Date: Fri, 25 Sep 2026 18:11:37 +0200
Message-ID: <20260925161142.189813-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925161142.189813-1-parri.andrea@gmail.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_HWPT_GET_DIRTY_BITMAP can set bits in the caller's memory past the
end of the bitmap.  When the queried range ends inside a dirty huge
IOPTE, the generic page-table dirty code records the whole entry, and
iova_bitmap_set() then sets every bit up to the end of the pinned page.

iova_bitmap_mapped_range() checks a range only against the pages
currently pinned, and iova_bitmap_mapped_length() caps only the pinning
window, so neither limits the write.  A range that starts inside the
bitmap but ends past it passes iova_bitmap_advance_to() on its start,
and the write loop runs to the end of the last pinned page.

Clip the range to [bitmap->iova, bitmap->iova + bitmap->length - 1]
before computing cur_bit and last_bit.  A range that starts before the
bitmap now has its in-range part recorded; the unsigned underflow in
iova_bitmap_advance_to() previously rejected it whole.

The clip runs before any pinning or indexing, so for a validated query
range cur_bit and last_bit can no longer address outside the bitmap.  It
only narrows the requested range; the bitmap bounds are fixed at
allocation.

Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index dac3e657d498d..44826ae330c4b 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -388,6 +388,30 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
 
+/*
+ * Trim [@iova..@iova+@length-1] to the IOVA range covered by @bitmap.
+ * Dirty trackers may report more than was asked for, for instance a whole
+ * huge IOPTE of which only a part was queried.
+ */
+static bool iova_bitmap_clip(struct iova_bitmap *bitmap, unsigned long *iova,
+			     size_t *length)
+{
+	unsigned long first = max(*iova, bitmap->iova);
+	unsigned long last = bitmap->iova + bitmap->length - 1;
+	unsigned long end;
+
+	if (!*length)
+		return false;
+	if (!check_add_overflow(*iova, *length - 1, &end))
+		last = min(last, end);
+	if (first > last)
+		return false;
+
+	*iova = first;
+	*length = last - first + 1;
+	return true;
+}
+
 /**
  * iova_bitmap_set() - Records an IOVA range in bitmap
  * @bitmap: IOVA bitmap
@@ -404,6 +428,9 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
 	unsigned long cur_bit, last_bit, last_page_idx;
 
+	if (!iova_bitmap_clip(bitmap, &iova, &length))
+		return;
+
 update_indexes:
 	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
 		/*
-- 
2.53.0

