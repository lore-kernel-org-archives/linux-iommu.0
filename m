From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu: add support for ARM Ltd. System MMU
	architecture
Date: Mon, 08 Jul 2013 09:34:23 -0700
Message-ID: <51DAEA0F.2030808@codeaurora.org>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
	<1372095086-15681-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1372095086-15681-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 6/24/2013 10:31 AM, Will Deacon wrote:
> This patch adds support for SMMUs implementing the ARM System MMU
> architecture versions 1 or 2. Both arm and arm64 are supported, although
> the v7s descriptor format is not used.
> 
> Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
> +/* Maximum number of stream IDs assigned to a single device */
> +#define MAX_MASTER_STREAMIDS		8
> +

Hi Will,

We have designs that require more than 8 Stream IDs. Instead of hard
coding it to max of 8 can you make this dynamic?

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
