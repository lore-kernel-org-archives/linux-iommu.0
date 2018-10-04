From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
Date: Fri, 5 Oct 2018 00:19:37 +0530
Message-ID: <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
	<1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1538605693-22073-3-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, aisheng.dong-3arQi8VN3Tc@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Thor,


On 10/4/2018 3:58 AM, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> Add a clock to the SMMU structure. In the device tree case,
> check for a clock node and enable the clock if found.
>
> This patch is dependent upon the following patches that add
> a device tree bulk clock function.
> "[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
> https://patchwork.kernel.org/patch/10583133/
> "[V6, 2/4] clk: add new APIs to operation on all available
> clocks"
> https://patchwork.kernel.org/patch/10583131/
> "[V6, 3/4] clk: add managerged version of clk_bulk_get_all"
> https://patchwork.kernel.org/patch/10583139/
>
> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

The clock part is already handled by one of the patch in the
runtime pm series of arm-smmu [1]. This patch should not be needed.

[1] https://patchwork.kernel.org/patch/10581899/

[...]

Regards
Vivek
