From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] iommu/tegra-gart: Add iommu_group support
Date: Wed, 26 Jul 2017 23:56:58 +0300
Message-ID: <e1de80c6-33fd-6bd5-bc28-8b3d3043ca4f@gmail.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
	<9c3fa9661e8177f0ccea960dd584a05fc19f92c8.1500637633.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9c3fa9661e8177f0ccea960dd584a05fc19f92c8.1500637633.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 21.07.2017 15:12, Robin Murphy wrote:
> As the last step to making groups mandatory, clean up the remaining
> drivers by adding basic support. Whilst it may not perfectly reflect the
> isolation capabilities of the hardware, using generic_device_group()
> should at least maintain existing behaviour with respect to the API.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Tested-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

-- 
Dmitry
