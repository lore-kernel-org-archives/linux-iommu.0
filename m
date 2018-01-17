From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/msm: Claim bus ops on probe
Date: Wed, 17 Jan 2018 13:39:18 +0000
Message-ID: <bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
	<20180117133331.vidtyduiu7zr3fwc@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180117133331.vidtyduiu7zr3fwc-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/01/18 13:33, Joerg Roedel wrote:
> On Mon, Jan 08, 2018 at 06:42:30PM +0000, Robin Murphy wrote:
>> Since the MSM IOMMU driver now probes via DT exclusively rather than
>> platform data, dependent masters should be deferred until the IOMMU
>> itself is ready. Thus we can do away with the early initialisation
>> hook to unconditionally claim the bus ops, and instead do that only
>> once an IOMMU is actually probed. Furthermore, this should also make
>> the driver safe for multiplatform kernels on non-MSM SoCs.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> Applied both, thanks Robin.

Oops, patch #2 of this series will break the build, as it was 
accidentally based on an older branch missing the Renesas IPMMU updates. 
Please see v2 [1] - I'm still hoping for confirmation from the Renesas 
folks, but it *should* be fine...

Incidentally, per your other mail, these changes also makes Jeffy's 
"Only do IOMMU lookup for available ones" patch obsolete.

Sorry for the mess,
Robin.

[1] 
https://lists.linuxfoundation.org/pipermail/iommu/2018-January/025395.html
