Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47119D880
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896722; cv=none; b=bIizg5Fybge0889QOg7WFR23THLx2Gh4vnc7YpPbcrvzg64X4bghxLjEx0aenoGjxcwL8H+V0on2s+df/qgM6osPjWOeeWZjO5mzUQTtBZVJ7wEWtrqqreVF3b9jhvd3gdisdkP3Idxsxp3x7Uh5bZGdCDo3rL4+rwNKYSu/x1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896722; c=relaxed/simple;
	bh=wkniiIbVVMt7AJg5Ojd6J8vayPVPSFRZdAycRjCeEJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFEwM4K4UuhvYIxh0mN94K5Ucr2ELWvgjwWiuTpA7u/W/XRBytlvRScdzalomAyLTTGXl97llZWS4ZTOOFvf+9l89YKLV3yzJ5IY5oObK4yFtq8Q2vALvKG6yOczAmL8jHLcFweq1f3TDzO+KfBZ8nJe4jD9dZWZt5MgmdMDknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 330E42009184;
	Mon,  7 Jul 2025 15:58:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 268BA4D174; Mon,  7 Jul 2025 15:58:30 +0200 (CEST)
Date: Mon, 7 Jul 2025 15:58:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hansg@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, David Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
Message-ID: <aGvShrJJTj2ERdZr@wunner.de>
References: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
 <aGbaNd3qCK3WvAe-@tassilo>
 <4ef523a2-48b3-45e9-94da-7811e1bfae76@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef523a2-48b3-45e9-94da-7811e1bfae76@kernel.org>

On Mon, Jul 07, 2025 at 02:53:32PM +0200, Hans de Goede wrote:
> So I think we should move forward with Lukas' fix dor 6.16 and then
> my patch to disable probing of unsupported devices by default can
> be merged into linux-next .

Sounds good to me.

Dave is out all week and has not commented on this matter at all so far:

https://lore.kernel.org/r/CAPM=9tzrmRS9++MP_Y4ab95W71UxjFLzTd176Mok7akwdT2q+w@mail.gmail.com/

I assume Bjorn may not be comfortable applying my patch without an ack
from Dave.  I am technically able to apply my own patch through drm-misc
and I believe Hans' Reviewed-by is sufficient to allow me to do that.

I'd feel more comfortable having additional acks or Reviewed-by's though.
I'm contemplating applying the patch to drm-misc by Wednesday evening,
that would allow it to land in Linus' tree before v6.16-rc6.

If anyone has objections, needs more time to review or wants to apply
the patch, please let me know.

Thanks,

Lukas
