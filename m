From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document
 of Exynos System MMU
Date: Mon, 28 Apr 2014 11:52:24 -0600
Message-ID: <535E9558.8010803@wwwdotorg.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4447051.OnJtcFSqFV@wuerfel> <20140428103919.GF19455@ulmo>
 <6544270.ddFBoY6LMm@wuerfel> <20140428111802.GI19455@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140428111802.GI19455@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: t.figa@samsung.com, Will Deacon <will.deacon@arm.com>, tomasz.figa@gmail.com, joshi@samsung.com, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, kgene.kim@samsung.com, prathyush.k@samsung.com, sachin.kamat@linaro.org, joro@8bytes.org, devicetree@vger.kernel.org, grundler@chromium.org, linux-samsung-soc@vger.kernel.org, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, linux-arm-kernel@lists.infradead.org, rahul.sharma@samsung.com, Shaik Ameer Basha <shaik.ameer@samsung.com>, supash.ramaswamy@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On 04/28/2014 05:18 AM, Thierry Reding wrote:
> On Mon, Apr 28, 2014 at 12:56:03PM +0200, Arnd Bergmann wrote:
...
>> A lot of drivers probably only support one
>> master, so they can just set #iommu-cells=<0>, others might require
>> IDs that do not fit into one cell.
> 
> You mean "#iommu-cells = <1>" for devices that only require one master?
> There still has to be one cell to specify which master. Unless perhaps
> if they can be arbitrarily assigned. I guess even if there's a fixed
> mapping that applies to one SoC generation, it might be good to still
> employ a specifier and have the mapping in DT for flexibility.

#iommu-cells doesn't include the phandle, so if you want the client
references to be:

property = <&iommu>;

then that's #iommu-cells=<0>, whereas:

property = <&iommu N>;

is #iommu-cells=<1>.
