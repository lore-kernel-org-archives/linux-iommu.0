From: kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_iommu=3A_use_dev=5Fget=5Fplatdata=28=29?=
Date: Tue, 28 Oct 2014 05:58:09 -0400 (EDT)
Message-ID: <1414490289.8326098@apps.rackspace.com>
References: <1412947870-10033-1-git-send-email-kiran.padwal@smartplayin.com>
	<20141022143021.GI10074@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141022143021.GI10074-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On Wednesday, October 22, 2014 10:30am, "Joerg Roedel" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> said:

> On Fri, Oct 10, 2014 at 07:01:10PM +0530, Kiran Padwal wrote:
>> Use the wrapper function for retrieving the platform data instead of
>> accessing dev->platform_data directly.
>>
>> Signed-off-by: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
>> ---
>>  drivers/iommu/msm_iommu_dev.c |    4 ++--
>>  drivers/iommu/omap-iommu.c    |    6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> This touches 2 drivers, can you please split it up into per-driver
> patches?

Sure, I will resent the separate patches.
sorry for delayed response.
 
Thanks,
--Kiran
