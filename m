From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
 infrastructure
Date: Thu, 3 May 2018 14:21:33 +0200
Message-ID: <20180503122133.GA18590@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: zajec5@gmail.com, linux-pci@vger.kernel.org, jarkko.sakkinen@linux.intel.com, david.brown@linaro.org, thierry.reding@gmail.com, frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com, vinod.koul@intel.com, bharat.bhushan@nxp.com, rafael.j.wysocki@intel.com, linux@armlinux.org.uk, andy.gross@linaro.org, msuchanek@suse.de, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, johan@kernel.org, robh+dt@kernel.org, dri-devel@lists.freedesktop.org, bhelgaas@google.com, dan.j.williams@intel.com, linux-soc@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

VGhpcyBzdGlsbCBmYWlscyB0byBhcHBseSBhZ2FpbnN0IGVpdGhlciA0LjE3LXJjMyBvciBjdXJy
ZW50IExpbnVzCm1hc3RlciBmb3IgbWUuICBQbGVhc2UgcmVzZW5kIGFnYWluc3QgaXQsIGFuZCBt
ZW50aW9uIHRoZSB0cmVlIGl0CmlzIGFnYWluc3QuCgpBbHNvIHBsZWFzZSByZXNlbmQgaXQgaW4g
YSBzZXBhcmF0ZSBlbWFpbCB0aHJlYWQgKGFsbCB5b3VyIHBhdGNoZXMKd2VyZSByZXBsaWVzIHRv
IHRoZSBwcmV2aW91cyBvbmVzKSBhbmQgaW5jbHVkZSBhIGNvdmVyIGxldHRlci4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
