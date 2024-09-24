Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135917F460;
	Tue, 24 Sep 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210855; cv=none; b=CXuICuqyJH3YYv+IOzbjIhfs6K6RNZrvD1U2P5OTlJjeuBDv4IPdcp4UgT8Sf1N9CdrYv7VJ5b/eI7qeoG3QxPTiOnwn+QYTrBTQZ5opnAi/FHHgyqc5NhaG49nk7VcbGDzbqwxRDk9yTGXMMTImHyg1AICdGsc6c4XtGUtRs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210855; c=relaxed/simple;
	bh=8YY2+iZu33kWOBOmGcTaVXJV/8VwiIfVjumsFG+oRrg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l7gz+a8ScZcuhRMrINZX6GsIp4PQ02kFksNXpaogD3YAj3b9lLT96vyFUChya/tHRKqBqV1kYSj8T5iEa5JCaAMPhtKhtnX9LmNcYXAPxQuunrwPz0tC3hPdiiHuWoDACdnqa9ozwLZk83AAkb9K3j4ToLcwe7cU1L3Nm/tvpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBNgn6tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBNgn6tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5759AC4CEC4;
	Tue, 24 Sep 2024 20:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727210854;
	bh=8YY2+iZu33kWOBOmGcTaVXJV/8VwiIfVjumsFG+oRrg=;
	h=Date:From:To:Cc:Subject:From;
	b=tBNgn6tw0pE4sfX5Xcbtn2lwkO/5MF8hooQlt+NrxqEmbNQLW384KRCHUSU9lbU6q
	 Xz4H/fdWUuk+mrFVhvcYh/yB4cAYx2vByfXX4VG1TtRj4sKgOKvz5ttoN3qe4CGzOd
	 PKSIksnOnHnJN/qAoZyP/tEwIN1oPptMmB4aGCFo=
Date: Tue, 24 Sep 2024 16:47:30 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Bouncing maintainer: Xiang Chen (DMA MAPPING BENCHMARK)
Message-ID: <20240924-fanatic-wakeful-oyster-62f4fd@lemur>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

I'm reaching out to the list associated with this subsystem:

  - DMA MAPPING BENCHMARK

The email address for the only maintainer listed for that subsystem is
bouncing:

  M: Xiang Chen <chenxiang66@hisilicon.com>

There are several possible courses of action:

1. If anyone knows the new email address for the maintainer, please ask them
   to submit a patch for MAINTAINERS and .mailmap files.

2. If this maintainer stepped away from their duties, please submit a patch to
   MAINTAINERS to update the M: entry with the new maintainer for this
   subsystem.

3. If there is no new maintainer for this subsystem, it will be marked as
   Orphaned.

The goal is to have no bouncing M: entries in the maintainers file, so please
follow up as soon as you have decided on the correct course of action.

Best regards,
--
Konstantin Ryabitsev
Linux Foundation

bugspray track
