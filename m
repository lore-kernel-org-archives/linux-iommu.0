From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM SMMU fixes
Date: Tue, 08 Apr 2014 14:57:43 +0100
Message-ID: <53440057.6020703@arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<2243447.NTvYmPQWSB@avalon> <93132940.WGeAzvU3EP@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <93132940.WGeAzvU3EP@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 08/04/14 14:41, Laurent Pinchart wrote:
> I've obviously forgotten that Will was away for a month. CC'ing Marc Zyngier.
> 
> On Thursday 03 April 2014 01:52:55 Laurent Pinchart wrote:
>> On Friday 28 February 2014 16:37:08 Laurent Pinchart wrote:
>>> Hello Will,
>>>
>>> I've studied your arm-smmu driver as a base to write a Renesas IOMMU
>>> driver and found two small issues. Here are patches to fix them. Please
>>> bear with me if my understanding was incorrect and the patches wrong :-)
>>>
>>> Laurent Pinchart (2):
>>>   iommu/arm-smmu: Replace list walk with platform driver data
>>>   iommu/arm-smmu: Return 0 on unmap failure
>>>  
>>>  drivers/iommu/arm-smmu.c | 17 +++++------------
>>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> Do you plan to take these patches (or at least patch 2/2) in your tree ? I
>> can send a pull request to Joerg if you give me your acked-by.
> 
> Marc, would you like to handle this, or would you prefer to wait until Will 
> comes back ?

Hi Laurent,

Yup, I'll have a look and stash them in a temp tree. Given that Will
will be back in about a week, he will have the final say.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
