From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
	from a domain
Date: Thu, 24 Jan 2019 03:25:19 +0000
Message-ID: <54a1da19-54dd-30cc-191b-7fe5dc4a58fa@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
	<20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
	<60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
	<20190116170852.GD4681@8bytes.org>
	<0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
	<20190122104454.nke2knuyqiswfh5w@8bytes.org>
	<e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
	<20190123075658.GE32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190123075658.GE32526-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <342ACEEFC1AC6347A1BFEC3E7373A5BE-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Singh, Brijesh" <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Joerg,

On 1/23/19 2:56 PM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> Hi Suravee,
> 
> On Tue, Jan 22, 2019 at 03:53:18PM +0000, Suthikulpanit, Suravee wrote:
>> Thanks for the detail. Alright then, let's just go with the version you
>> sent on 1/16/19. Do you want me to resend V3 with that changes, or
>> would you be taking care of that?
> 
> Please send me a v3 based on the diff I sent last week. Also add a
> separate patch which adds the missing dte flush for the alias entry.
> 
> Thanks,
> 
> 	Joerg
> 

Actually, I just noticed that device_flush_dte() has already handled flushing the DTE
for alias device as well. Please see the link below.

https://elixir.bootlin.com/linux/latest/source/drivers/iommu/amd_iommu.c#L1219

So, we don't need to call device_flush_dte() for alias device in do_detach().

Regards,
Suravee
