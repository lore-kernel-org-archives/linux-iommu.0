From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH RESEND] iommu/exynos: Improve page fault debug message
Date: Fri, 4 Nov 2016 09:24:21 -0300
Message-ID: <eed2456c-91a4-254e-e3fb-878486a5a4e7@osg.samsung.com>
References: <CGME20161104075817eucas1p2fe178b13386ff0e03592d2a2094c0ac0@eucas1p2.samsung.com>
 <1478246289-21525-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1478246289-21525-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On 11/04/2016 04:58 AM, Marek Szyprowski wrote:
> Add master device name to default IOMMU fault message to make easier to
> find which device triggered the fault. While at it, move printing some
> information (like page table base and first level entry addresses) to
> dev_dbg(), because those are typically not very useful for typical device
> driver user/developer not equipped with hardware debugging tools.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
