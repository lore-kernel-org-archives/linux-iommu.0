From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
	from a domain
Date: Thu, 24 Jan 2019 09:04:31 +0100
Message-ID: <20190124080431.GG32526@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
	<20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
	<60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
	<20190116170852.GD4681@8bytes.org>
	<0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
	<20190122104454.nke2knuyqiswfh5w@8bytes.org>
	<e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
	<20190123075658.GE32526@8bytes.org>
	<54a1da19-54dd-30cc-191b-7fe5dc4a58fa@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54a1da19-54dd-30cc-191b-7fe5dc4a58fa-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Singh, Brijesh" <brijesh.singh-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Thu, Jan 24, 2019 at 03:25:19AM +0000, Suthikulpanit, Suravee wrote:
> Actually, I just noticed that device_flush_dte() has already handled flushing the DTE
> for alias device as well. Please see the link below.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/iommu/amd_iommu.c#L1219
> 
> So, we don't need to call device_flush_dte() for alias device in do_detach().

You are right, I missed that.

Thanks,

	Joerg
