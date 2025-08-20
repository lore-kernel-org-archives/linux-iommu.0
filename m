Received: from va-1-16.ptr.blmpb.com (va-1-16.ptr.blmpb.com [209.127.230.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA032836AF
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688662; cv=none; b=GLRrAbgtHXjLjzH/1KGcCpgtkQLt/21xNSlKwiP0EAzA+OvnIDmGcNI68dbeoTlYxDy1peb5BsFeP1OaQPsIlBvefe7+qQN5NvSbQb5Uk7yBi8Gk1NACSBFvoJQgi7HGfiIVVU5TW8N/BYgtJItIa8xf+IrIBYxNBwvrwjzZL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688662; c=relaxed/simple;
	bh=mzjRYT0rbzh6fz3WHdLobxA8DIlPVPxQ8fNKl0ROwWg=;
	h=Mime-Version:Content-Type:Message-Id:To:Subject:Date:In-Reply-To:
	 Cc:From:References; b=QFh7/X4nitS0N2ViFCkvYpbM42tVf3WiHeBCL4mgng6XNmuZk7lwBQTc36mqq4nUUuF3iLT3JZlUNi/3T/zv95c5C3vml++/emfe+brzArk4Z6qW82Sa/heAq05qTHJGLQIQD31tSMeaLHzfl/Qlcb9dNI0q3SZdy7aLQDuUfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=WZs4rKGN; arc=none smtp.client-ip=209.127.230.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="WZs4rKGN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755688614;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=mzjRYT0rbzh6fz3WHdLobxA8DIlPVPxQ8fNKl0ROwWg=;
 b=WZs4rKGNAiVBUVAN987iRAzrCQuRlEqBEwwV60b9hNKLl6lyYhmST7WhCjtaHzpGg/xVAv
 iXu/hMI6miT0IRHzBIyp5azjmbVPzm+F6IBPOTYImvTPt8nsa2y4eDxhUZ40VDvvOIb8Mp
 R3jMeG2JVYc0GsCvzJD7PM3vXuWx2kexHPSMXvfPtp2ynMrejbqSTFKo0xLqGbH7jZjMzM
 VEaD5D2Y2Q5n5xVfWw7fgKW+iu3M0t4p8q4J62Aceax8GVxJMtO+Q8lSCoKhHv9WFRff8q
 smqyjli1s2oGEaMX+iXOaBDxyed7j4RAJHfM8KE9dIf/Nw57NkyDzGyLE0Y0qg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 20 Aug 2025 19:16:52 +0800
Content-Type: text/plain; charset=UTF-8
Message-Id: <20250820111643.19464-1-huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+268a5aea5+411548+lists.linux.dev+huangxianliang@lanxincomputing.com>
To: <markus.elfring@web.de>
Subject: Re: Re: [v4] iommu/riscv: prevent NULL deref in iova_to_phys
Date: Wed, 20 Aug 2025 19:16:43 +0800
In-Reply-To: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
References: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
Content-Transfer-Encoding: 7bit

> Does it trigger undesirable communication difficulties?
No, and I agree that both subject and summary phrase can be improved

And now I do learn from this, thanks.
> Your patch will almost certainly get comments from reviewers on ways in
> which the patch can be improved, in the form of a reply to your email. You must
> respond to those comments; ignoring reviewers is a good way to get ignored in
> return. You can simply reply to their emails to answer their comments. Review
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n310

Regards,
Xianliang
