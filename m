Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCF12CDBA;
	Tue, 24 Sep 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211015; cv=none; b=HA0SCnp8XwPOUjZV7E3ufiL4XKdjDRBtye6FWiYrN6o1Y2nxJjoW6ZcPVyt2hXI/9oluYo3mCMab3n5Wip2Ru+SbxEDj7zOz/SIFvbWDbCimsUv7aXwoQEIIkWVYqiUVA9dT6yfUd0T0+JwuvV3Dd/N+wqJIHi0gnvhDivGUnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211015; c=relaxed/simple;
	bh=+NPjSWacDLjPJgRAhq+c4FwOGHb//fXFa2x9dblT2dg=;
	h=MIME-Version:Content-Type:From:To:Message-ID:In-Reply-To:
	 References:Subject:Date; b=CdIftahYxitgFIZBQQN6oUbclyCCAjtvvNUVwN8wyQxESIBiKqL711kQftvIIgoZnzXOdG7WIhndWeaU2+twXLksM24X6tNGTdtOEuiRYORT74Flk5obR5P5WngE8JjnM1u0gpXhcEGld7mBM2fwO4vDwkVzAwMH4vYwwcJ/onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib5ILVGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib5ILVGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86D0C4CEC4;
	Tue, 24 Sep 2024 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727211014;
	bh=+NPjSWacDLjPJgRAhq+c4FwOGHb//fXFa2x9dblT2dg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ib5ILVGgCn92PyWy31nL5lKqOaNQjf2c2wGJq35ndFYJkK9i1zbkKQhGmbs7UTrsw
	 Rkrp+UUJ7pveyEhFfB8P15wVTe1zXPJST3qXD8JDebOKtskz3Av8ZUUwtorlDJ7icu
	 qDImFLwv5OMYkcZDEfpnZc272Hm9WZiFOOHYItmlvXaL8HTRuhX30Jjgu3bXAphNAi
	 G/13uvvQ5EZsnnK/zwSYhONG+PSVsY0o9Pke7t7LmbSh+zQ0UD9dbKZekI+wJDM3hY
	 ra0iOxJPQh03uydwD0Z2HVwtbyTRFaW1MvUzO1IClb1OHVyGFuS0hY3mCPj3DkqM0s
	 2feNyp0MSFssg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 397093806656;
	Tue, 24 Sep 2024 20:50:18 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: Bugspray Bot <bugbot@kernel.org>
To: linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org, 
 iommu@lists.linux.dev, helpdesk@kernel.org
Message-ID: <20240924-b219317-a7ea82437ff6@bugzilla.kernel.org>
In-Reply-To: <20240924-fanatic-wakeful-oyster-62f4fd@lemur>
References: <20240924-fanatic-wakeful-oyster-62f4fd@lemur>
Subject: Re: Bouncing maintainer: Xiang Chen (DMA MAPPING BENCHMARK)
X-Bugzilla-Product: kernel.org
X-Bugzilla-Component: Helpdesk
X-Mailer: bugspray 0.1-dev
Date: Tue, 24 Sep 2024 20:50:18 +0000 (UTC)

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=219317

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

