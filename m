From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
Date: Mon, 7 Mar 2016 23:38:47 -0800
Message-ID: <20160308073847.GA15520@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
To: Niklas S??derlund <niklas.soderlund+renesas@ragnatech.se>
Cc: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Please add some documentation on where/how this should be used.  It's
not a very obvious interface.
