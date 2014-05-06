From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Take mmap_sem when calling get_user_pages
Date: Tue, 6 May 2014 20:14:39 +0200
Message-ID: <20140506181438.GD12376@8bytes.org>
References: <1398724066-3730-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398724066-3730-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kim.naru@amd.com, jay.cornwall@amd.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 28, 2014 at 05:27:46PM -0500, Suthikulpanit, Suravee wrote:
> From: Jay Cornwall <jay.cornwall@amd.com>
> 
> get_user_pages requires caller to hold a read lock on mmap_sem.

Right, but can't we just switch to get_user_pages_fast instead?


	Joerg
