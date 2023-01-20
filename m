Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D617F7
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 11:15:27 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E1AB96602D25;
	Fri, 20 Jan 2023 11:15:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1674213325;
	bh=pk0IDna2rdFOCASraCLd7evCkGbMHFk7ARo77hGlbMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K2MOTQvLN7GOlV57FsPI26ZCkig6YDHIcebXCASlOI+Dtrp0mjLBJCY6iy95WiFvl
	 1mnskzibbi3R6xOjsgp1d8CLmRCYv94hF8xjwpcWPQ0xSHRc90X2XsfYNBxL+HZuJ3
	 IJ+qtg9RzoV6K81BA87zEV9pQWcsZEKN2ysjtGynroVr7hYF2hsqD4Q5JC6iAltSmB
	 xwnSWQrafRZ0QtcA/Psi//KI3ntUbP0OInTF52KXaU44UkekjRDP3Wge9BUTRne+Lg
	 EV8p4arvjD/f0WjC8EAc6Qb+OW7TF5akWw32mYkdQbtjYvMMTaMzk/G/cqgeFLTnfI
	 QftUW5bfliLTw==
Message-ID: <8f7bda23-7063-d2ff-9b5d-b1604052a502@collabora.com>
Date: Fri, 20 Jan 2023 12:15:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/3] iommu/sound: Use component_match_add_of helper
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Joerg Roedel <joro@8bytes.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.com>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 alsa-devel@alsa-project.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20230119191040.1637739-1-sean.anderson@seco.com>
 <20230119191040.1637739-3-sean.anderson@seco.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230119191040.1637739-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/01/23 20:10, Sean Anderson ha scritto:
> Convert users of component_match_add_release with component_release_of
> and component_compare_of to component_match_add_of.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Mark Brown <broonie@kernel.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


