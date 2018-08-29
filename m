From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: various dma_mask fixups
Date: Wed, 29 Aug 2018 08:59:48 +0200
Message-ID: <CACRpkdaHfNE7aPc5G6u7aGaXjq9ccpvtmnRyFg2n+g52eqY22w@mail.gmail.com>
References: <20180829062401.8701-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, mroos@linux.ee, Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 29, 2018 at 8:24 AM Christoph Hellwig <hch@lst.de> wrote:

> Fix warnings and regressions from requiring a dma mask.

Applied all three patches and took a few ARM systems for a test ride:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
