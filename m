Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C795475E
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007228; cv=none; b=DnzrBp3EtWbLID7pEhNgXPRris8QcLCiE9gd/HKC+B4/JhrrZXx+gJo4zc8fsNljDhRwhRuG9GNNUZLsvui8FfXF4Cceh5mJiF9EtrcQR7sGbcKq2yhJn31z+cZ26Bx1veAxpttsVmDyxaA4AYTYsPseLIv4OvGZyn3SvJ7WSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007228; c=relaxed/simple;
	bh=Yo3z90k4twSlPMQYzOIKH9VTAjl/qG2Op4HCeH55WXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9ksOnoDeGudVB3LYi6jDfLkdD0nDIEkHjk0XvBA5cLvZDLKA6o6nJ9tho9MWEcTwlx6srzvoKqsZgj/tmUXBeCuQ0nJQv9Lj0LZ6im18ev4JH6yXxPGUJJNwmJSXh4kByF/Yc+M8B0jSxlv/mZ9nUI+rySCGKVKi9IR7sHoZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=GIeiHA7U; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="GIeiHA7U"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0651C4D686;
	Fri, 27 Jun 2025 08:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751007226;
	bh=Yo3z90k4twSlPMQYzOIKH9VTAjl/qG2Op4HCeH55WXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIeiHA7U0rvouipHa47iAzncUxTCQ+sl6rHavIs/5wTRL/9XtEcDm0e4w6pxYJg1/
	 UeIxlB/kbUkgCj3T42D0ZDsfIHTHmMHkZz9kPBG3vmt7QgB9f8Pua4LXvJmPwmsXVV
	 +jgsJVxe/yslNZpeI31FDAadS2E0eup7b77vUkMAKcwKUdvtsoE7CITl952Vfta98n
	 pQmK033gtIOZgohl50TNLLO87RORo5Yg4kwKp0pCUdplhGlrXxpaBbq1QGC+rnt64Q
	 qmYMKQ37X5SJACBLMNEH7Z4wvYELZ6LieKGqDey3MBb2jHlKDEH+i3hZME/TFat5+c
	 cAnyrgs25gZKw==
Date: Fri, 27 Jun 2025 08:53:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Vasant.Hegde@amd.com
Subject: Re: [PATCH v6 0/8] Introduce debugfs support in IOMMU
Message-ID: <aF4_-F4utWGgcwWY@8bytes.org>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
 <dbec455c-74a0-4f91-8b8c-7b995c6e3e9c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbec455c-74a0-4f91-8b8c-7b995c6e3e9c@amd.com>

Hi Dheeraj,

On Thu, Jun 26, 2025 at 11:27:54AM +0530, Dheeraj Kumar Srivastava wrote:
> Just a friendly reminder to review the patch series. Your valuable feedback
> would be greatly appreciated to help us move forward.

Will merge once acked/reviewed by Suravee or Vasant.

Regards,

	Joerg
