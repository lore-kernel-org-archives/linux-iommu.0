Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB717BB21
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456775; cv=none; b=bRSMa9JI/+Lf+RPiUZoyB3LdGkP9JJ7yisQ+ntnLFWwdGSiHt9HFs73hBB1G4NybmT3twJjNSgK15E4I7eWejxfq4vciJwWKmHVT6qmDb7F4VyRI7jEcSDcU8nrW2ifd7ie2fjED0hEQ0Ez4fMoi06MDUMFpHOXFkCpHLNJpJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456775; c=relaxed/simple;
	bh=sgkeM8X8WN2YXeHC3V9W5+XFVXkwhzLs2jKrJZRqNa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BYAhrMuaBMfYYaKs5NUMLmjPAbPQ/pGkmgMkHZEzcjLGCv4bRhpyhhOs1OyOcWl6kXu3/2/pFysSG9aemHy5Ygk0T3W0sCi13D/ieZDZc6io6ePSsdWvHCB05kAdeReyycHsC7PpgI4MMhAuxON7dDp1HoBfkUb3Zo3MpYzDiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOW2bzNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOW2bzNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766456772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zi4oyCc5/0xxSx6mN99a28+uzJNnasIcIl0Y9zet9JM=;
	b=JOW2bzNnNxri5KRr3FQHQe6CGhxIHUMaA9395zsaQ1FsB+eqD1e7VzUVPlL2ssrFXtvOBh
	Dc/QMJKYoRnto+O2wiyTWU1v+5ZvlqTRmayR8ahVrRcJmZIdJFvByFhtJDFO6wsvVpoCp6
	944+dKArvybtOEa3djPn+WxAeGAUvJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-XQCB8_ptOAai97cvo69YSg-1; Mon,
 22 Dec 2025 21:26:08 -0500
X-MC-Unique: XQCB8_ptOAai97cvo69YSg-1
X-Mimecast-MFC-AGG-ID: XQCB8_ptOAai97cvo69YSg_1766456767
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9676F195605A;
	Tue, 23 Dec 2025 02:26:07 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7012530001A2;
	Tue, 23 Dec 2025 02:26:05 +0000 (UTC)
Date: Tue, 23 Dec 2025 10:26:00 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev
Subject: Question: AMD IOMMU v1 contiguous PTE OA encoding triggers
 FIELD_PREP overflow
Message-ID: <aUn9uGPCooqB-RIF@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OMKXEOCI0HfhyOTQIM2PGXNfATit3uDESWZI5APfqTE_1766456767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

While enabling CONFIG_CONSTRUCTORS + GCOV, I ran into a build-time
FIELD_PREP() overflow in amdv1pt_install_leaf_entry() for the
contiguous (NEXT_LEVEL = SIZE) mapping path.

Specifically, this block:

entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
                    AMDV1PT_FMT_NL_SIZE) |
         FIELD_PREP(AMDV1PT_FMT_OA,
            oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ - 1) - 1);

ends up producing a value that exceeds the width of AMDV1PT_FMT_OA
(GENMASK_ULL(51, 12)), which compiler detect and reject at build time.

However, I’m not familiar with the AMD IOMMU internals, so I wanted
to ask the list: is OA supposed to be re-encoded for SIZE mappings, or
is this overflow indicating that the OA field should be left unchanged
in this case?

Any guidance or correction would be greatly appreciated.

Thanks,
Chunyu Hu

--<
"""
In file included from <command-line>:
In function ‘amdv1pt_install_leaf_entry’,
    inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:651:3,
    inlined from ‘__map_single_page0’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1,
    inlined from ‘pt_descend’ at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
    inlined from ‘__do_map_single_page’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:658:10,
    inlined from ‘__map_single_page1.constprop’ at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1:
././include/linux/compiler_types.h:631:45: error: call to ‘__compiletime_assert_251’ declared with attribute error: FIELD_PREP: value too large for the field
  631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:612:25: note: in definition of macro ‘__compiletime_assert’
  612 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:631:9: note: in expansion of macro ‘_compiletime_assert’
  631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:69:17: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   69 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
      |                 ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:90:17: note: in expansion of macro ‘__BF_FIELD_CHECK_MASK’
   90 |                 __BF_FIELD_CHECK_MASK(mask, val, pfx);                  \
      |                 ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:137:17: note: in expansion of macro ‘__FIELD_PREP’
  137 |                 __FIELD_PREP(_mask, _val, "FIELD_PREP: ");              \
      |                 ^~~~~~~~~~~~
drivers/iommu/generic_pt/fmt/amdv1.h:220:26: note: in expansion of macro ‘FIELD_PREP’
  220 |                          FIELD_PREP(AMDV1PT_FMT_OA,
      |                          ^~~~~~~~~~
"""

